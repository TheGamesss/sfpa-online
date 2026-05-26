import { existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = dirname(dirname(fileURLToPath(import.meta.url)));

if (!existsSync(join(rootDir, "index.html"))) {
  throw new Error("index.html is missing.");
}
