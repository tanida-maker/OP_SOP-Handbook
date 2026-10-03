import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

// Temporary Q4 site (Vercel project "airportels-q4" sets NEXT_PUBLIC_APP_MODE=q4).
// The main SOP Hub project does not set it, so its behaviour is unchanged.
const Q4_MODE = process.env.NEXT_PUBLIC_APP_MODE === "q4";

// Paths that do NOT require a logged-in user.
const PUBLIC_PREFIXES = ["/login", "/auth", "/_next", "/favicon", "/icon", "/manifest"];

function isPublic(pathname: string) {
  return PUBLIC_PREFIXES.some((p) => pathname === p || pathname.startsWith(p));
}

// Refreshes the Supabase auth session on every request and gates access.
export async function updateSession(request: NextRequest) {
  let response = NextResponse.next({ request });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value)
          );
          response = NextResponse.next({ request });
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options)
          );
        },
      },
    }
  );

  // IMPORTANT: do not run code between createServerClient and getUser().
  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { pathname, search } = request.nextUrl;

  // Q4 site: the home page is the Q4 form.
  if (Q4_MODE && pathname === "/") {
    const url = request.nextUrl.clone();
    url.pathname = "/q4";
    return NextResponse.redirect(url);
  }

  // Not logged in and hitting a protected page → send to login.
  if (!user && !isPublic(pathname)) {
    const url = request.nextUrl.clone();
    url.pathname = "/login";
    url.searchParams.set("next", pathname + search);
    return NextResponse.redirect(url);
  }

  // Logged in but on the login page → send home.
  if (user && pathname === "/login") {
    const url = request.nextUrl.clone();
    url.pathname = Q4_MODE ? "/q4" : "/";
    url.search = "";
    return NextResponse.redirect(url);
  }

  return response;
}
