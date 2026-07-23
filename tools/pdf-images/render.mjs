// ============================================================
// Render SOP PDF pages to PNG images.
// Run on a machine WITHOUT Smart App Control (native canvas is required).
//
//   npm install
//   node render.mjs "C:/path/to/folder-with-pdfs"
//
// If no path is given, it looks in ./pdfs
// Output: ./output/<slug>/page-01.png, page-02.png, ...
// Folder names match the SOP slugs used in the web app, so you know
// exactly which document each image belongs to.
// ============================================================

import { createCanvas } from "@napi-rs/canvas";
import * as pdfjs from "pdfjs-dist/legacy/build/pdf.mjs";
import {
  readFileSync,
  writeFileSync,
  mkdirSync,
  readdirSync,
  existsSync,
} from "node:fs";
import { join, resolve } from "node:path";

const SCALE = 2; // ~144 DPI; raise to 3 for sharper images

// keyword (found in the PDF filename) -> web-app slug
const MAP = [
  ["AIRPORT LUGGAGE STORAGE", "dmk-airport-service"],
  ["POS", "pos-order-receiving"],
  ["Authorized Person Pickup", "authorized-person-pickup"],
  ["เปิด และปิดเคาน์เตอร์", "open-close-counter"],
  ["YOOWIFI", "yoowifi-service"],
  ["EDC", "edc-machine"],
  ["ชำระเงินด้วยบัตรเครดิตแบบออนไลน์", "online-credit-card-payment"],
  ["ไร้เงินสด", "cashless-payment-policy"],
  ["Inventory", "inventory-stock-update"],
  ["มารับสัมภาระล่าช้า", "delayed-pickup-discount"],
  ["Google Sheet", "luggage-delivery-google-sheet"],
  ["ฉุกเฉิน ณ จุดบริการ ภายในสนามบิน", "emergency-airport"],
  ["ฉุกเฉินสำหรับจุดบริการภายในศูนย์การค้า", "emergency-mall"],
  ["Respond.io", "respond-io-guide"],
  ["3CX", "3cx-guide"],
  ["แต่งกาย", "dress-code-guest-service"],
  ["Terms and Conditions", "terms-and-conditions-2025"],
];

function slugFor(filename) {
  for (const [kw, slug] of MAP) if (filename.includes(kw)) return slug;
  return null;
}

// pdf.js needs a canvas factory to rasterise in Node.
class NodeCanvasFactory {
  create(width, height) {
    const canvas = createCanvas(Math.ceil(width), Math.ceil(height));
    return { canvas, context: canvas.getContext("2d") };
  }
  reset(cc, width, height) {
    cc.canvas.width = Math.ceil(width);
    cc.canvas.height = Math.ceil(height);
  }
  destroy(cc) {
    cc.canvas.width = 0;
    cc.canvas.height = 0;
  }
}

async function renderPdf(pdfPath, slug, outRoot) {
  const data = new Uint8Array(readFileSync(pdfPath));
  const canvasFactory = new NodeCanvasFactory();
  const doc = await pdfjs.getDocument({
    data,
    canvasFactory,
    isEvalSupported: false,
    useSystemFonts: true,
  }).promise;

  const outDir = join(outRoot, slug);
  mkdirSync(outDir, { recursive: true });

  for (let p = 1; p <= doc.numPages; p++) {
    const page = await doc.getPage(p);
    const viewport = page.getViewport({ scale: SCALE });
    const { canvas, context } = canvasFactory.create(
      viewport.width,
      viewport.height
    );
    await page.render({ canvasContext: context, viewport, canvasFactory })
      .promise;
    const png = canvas.toBuffer("image/png");
    const name = `page-${String(p).padStart(2, "0")}.png`;
    writeFileSync(join(outDir, name), png);
  }
  console.log(`✓ ${slug.padEnd(28)} ${doc.numPages} page(s)`);
  return doc.numPages;
}

async function main() {
  const srcArg = process.argv[2];
  const srcDir = resolve(srcArg || "./pdfs");
  const outRoot = resolve("./output");

  if (!existsSync(srcDir)) {
    console.error(`Source folder not found: ${srcDir}
Put the SOP PDFs in a folder and pass its path:
  node render.mjs "C:/path/to/pdfs"`);
    process.exit(1);
  }

  const files = readdirSync(srcDir).filter((f) => f.toLowerCase().endsWith(".pdf"));
  console.log(`Found ${files.length} PDF(s) in ${srcDir}\n`);

  let matched = 0;
  let pages = 0;
  for (const f of files) {
    const slug = slugFor(f);
    if (!slug) {
      console.log(`- skip (no slug match): ${f}`);
      continue;
    }
    try {
      pages += await renderPdf(join(srcDir, f), slug, outRoot);
      matched++;
    } catch (e) {
      console.error(`✗ error on ${f}: ${e.message}`);
    }
  }

  console.log(
    `\nDone: ${matched} document(s), ${pages} page image(s) → ${outRoot}`
  );
  console.log(
    "Next: open each ./output/<slug>/ folder, then in the SOP Hub admin editor\n" +
      "upload the images you need where the [📷 ภาพประกอบ: ...] markers are."
  );
}

main();
