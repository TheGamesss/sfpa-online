import { promises as fs } from "node:fs";
import path from "node:path";
import process from "node:process";

const workspaceRoot = path.resolve(process.cwd(), "..");
const levelsRoot = path.join(workspaceRoot, "Levels");
const outputPath = path.join(process.cwd(), "Assets", "data", "level-manifest.json");

async function walk(currentDir, visitor) {
  const entries = await fs.readdir(currentDir, { withFileTypes: true });
  entries.sort((a, b) => a.name.localeCompare(b.name));
  for (const entry of entries) {
    const fullPath = path.join(currentDir, entry.name);
    if (entry.isDirectory()) {
      await walk(fullPath, visitor);
      continue;
    }

    await visitor(fullPath);
  }
}

async function main() {
  const manifest = [];
  await walk(levelsRoot, async (fullPath) => {
    if (path.extname(fullPath).toLowerCase() !== ".swf") {
      return;
    }

    const relativePath = path.relative(workspaceRoot, fullPath).replace(/\\/g, "/");
    const segments = relativePath.split("/");
    if (segments.length < 3) {
      return;
    }

    manifest.push({
      id: path.basename(fullPath, ".swf"),
      topLevelDir: segments[1],
      relativeDir: segments.slice(1, -1).join("/"),
      path: relativePath
    });
  });

  manifest.sort((a, b) => a.path.localeCompare(b.path));
  await fs.mkdir(path.dirname(outputPath), { recursive: true });
  await fs.writeFile(outputPath, JSON.stringify(manifest, null, 2) + "\n", "utf8");
  process.stdout.write(`Wrote ${manifest.length} entries to ${outputPath}\n`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
