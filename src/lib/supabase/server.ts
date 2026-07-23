import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";

// Server-side Supabase client (Server Components, Server Actions, Route Handlers).
// In Next.js 16 `cookies()` is async, so this factory is async too.
export async function createClient() {
  const cookieStore = await cookies();

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      // SOP Hub tables live in the isolated "sop" schema of the shared project.
      db: { schema: "sop" },
      cookies: {
        getAll() {
          return cookieStore.getAll();
        },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options)
            );
          } catch {
            // Called from a Server Component where cookies cannot be set.
            // Safe to ignore — the session is refreshed in proxy.ts instead.
          }
        },
      },
    }
  );
}

// Convenience: fetch the current user + whether they are a SOP admin.
// Admin status comes from sop.is_admin() (backed by the sop.admins table),
// kept independent from the Scheduling app's own permission system.
export async function getSessionUser() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return { user: null, isAdmin: false, fullName: null as string | null, supabase };
  }

  const { data: isAdmin } = await supabase.rpc("is_admin");
  const meta = user.user_metadata ?? {};
  const fullName: string =
    (meta.full_name as string) ||
    (meta.name as string) ||
    user.email?.split("@")[0] ||
    "พนักงาน";

  return { user, isAdmin: !!isAdmin, fullName, supabase };
}
