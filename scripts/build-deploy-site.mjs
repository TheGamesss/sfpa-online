import { cp, mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = dirname(dirname(fileURLToPath(import.meta.url)));
const nativeExportDir = join(rootDir, "native-port", "Export", "html5", "bin");
const siteTemplateDir = join(rootDir, "site");
const distDir = join(rootDir, "dist");
const distAppDir = join(distDir, "app");

async function copyFileIfPresent(sourcePath, destPath) {
  if (!existsSync(sourcePath)) {
    return;
  }

  await cp(sourcePath, destPath);
}

async function main() {
  if (!existsSync(nativeExportDir)) {
    throw new Error(`Native HTML5 export is missing: ${nativeExportDir}`);
  }

  await rm(distDir, { recursive: true, force: true });
  await mkdir(distDir, { recursive: true });

  await cp(nativeExportDir, distAppDir, { recursive: true });
  await cp(siteTemplateDir, distDir, { recursive: true });
  await copyFileIfPresent(join(siteTemplateDir, "app-bridge.js"), join(distAppDir, "app-bridge.js"));
  await copyFileIfPresent(join(rootDir, "banner.png"), join(distDir, "banner.png"));
  await copyFileIfPresent(join(rootDir, "favicon.ico"), join(distDir, "favicon.ico"));
  await copyFileIfPresent(join(rootDir, "3rd_party_license.txt"), join(distDir, "3rd_party_license.txt"));

  const appIndexPath = join(distAppDir, "index.html");
  const appIndex = await readFile(appIndexPath, "utf8");
  if (!appIndex.includes("./app-bridge.js")) {
    const patched = appIndex.replace(
      "</body>",
      '  <script src="./app-bridge.js" type="text/javascript"></script>\n</body>'
    );
    await writeFile(appIndexPath, patched, "utf8");
  }

  const noJekyllPath = join(distDir, ".nojekyll");
  await writeFile(noJekyllPath, "", "utf8");

  process.stdout.write(`Built deploy bundle in ${distDir}\n`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
