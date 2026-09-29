import { cp, mkdir, readdir, rm } from "node:fs/promises";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const outputDirectory = resolve(projectRoot, "dist");

if (relative(projectRoot, outputDirectory) !== "dist") {
  throw new Error("Refusing to build outside the project dist directory.");
}

await rm(outputDirectory, { recursive: true, force: true });
await mkdir(outputDirectory, { recursive: true });

async function copyDirectoryContents(source, destination) {
  await mkdir(destination, { recursive: true });
  for (const entry of await readdir(source, { withFileTypes: true })) {
    await cp(join(source, entry.name), join(destination, entry.name), {
      recursive: entry.isDirectory(),
      force: true,
    });
  }
}

await copyDirectoryContents(join(projectRoot, "web"), outputDirectory);
await mkdir(join(outputDirectory, "vendor"), { recursive: true });
await cp(join(projectRoot, "vendor", "ruffle"), join(outputDirectory, "vendor", "ruffle"), {
  recursive: true,
});
await cp(join(projectRoot, "SFPA-web.swf"), join(outputDirectory, "SFPA.swf"));
await cp(join(projectRoot, "gamepad.swf"), join(outputDirectory, "gamepad.swf"));
await cp(join(projectRoot, "Levels"), join(outputDirectory, "Levels"), { recursive: true });
await mkdir(join(outputDirectory, "licenses"), { recursive: true });
await cp(
  join(projectRoot, "3rd_party_license.txt"),
  join(outputDirectory, "licenses", "3rd_party_license.txt"),
);

const totalFiles = await countFiles(outputDirectory);
console.log(`Built ${totalFiles} files into ${relative(projectRoot, outputDirectory)}.`);

async function countFiles(directory) {
  let count = 0;
  for (const entry of await readdir(directory, { withFileTypes: true })) {
    count += entry.isDirectory() ? await countFiles(join(directory, entry.name)) : 1;
  }
  return count;
}
