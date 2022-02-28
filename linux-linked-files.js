/**
 * When isReverse, we are dealing with all files inside ./linux,
 * paths relative to ./linux, e.g., bin/my_script not linux/bin/my_script.
 * In either of isReverse, let make sure that the targetted path is there,
 * In case of isReverse = false, lets handle patterns to ignore that
 * starts with "!".
 *
 * When isDry = try, all the previous actions won't have physical
 * effect to the hard disk.
 */

const fs = require("fs");
const path = require("path");
const patterns = process.argv.slice(2);
const relativePaths = new Set();
const linkDirs = new Set();
const isDry = !!process.env.DRY;
const isForce = !!process.env.FORCE;
const isReverse = !!process.env.REVERSE;
const isFill = !!process.env.FILL;
let errorOccured = false;

while (patterns.length) {
  const p = patterns.shift();
  if (!isIncludedFile(p)) continue;
  const linkingData = getFileData(p);

  if (!fs.existsSync(linkingData.path))
    error("source path doesn't exist: " + linkingData.path);

  // if it is file
  if (fs.statSync(linkingData.path).isFile()) {
    if (fs.existsSync(linkingData.link)) {
      // this is now handled in the bash script
      // if (isFill) continue; // skip this file as it exists
      if (!isForce && !isFill)
        error(
          "targetted link will overwrite exsiting file: " + linkingData.link
        );
    }
    relativePaths.add(linkingData.relPath);
    linkDirs.add(linkingData.linkDir);
  } else {
    // it is directory
    let content = fs
      .readdirSync(linkingData.path, { withFileTypes: true })
      .map((dirent) => resolve(linkingData.path, dirent.name))
      .filter(isIncludedFile);
    // put the at the beginning of our patterns, FIFO
    patterns.unshift(...content);
  }
}

function resolve(...p) {
  let homeRootPath = p.find((_) => _.startsWith("~"));
  if (homeRootPath)
    return path.resolve(process.env.HOME, homeRootPath.slice(2));
  return path.resolve(...p);
}

function getFileData(f) {
  let relPath = f;
  if (!isReverse) {
    relPath = resolve(f); // if starts with ~, resolve it to get the full path
    relPath = path.relative(process.env.HOME, relPath);
    if (relPath.startsWith("..")) {
      error("patterns should be inside the $HOME directory");
    }
  }
  let linksRootDir = isReverse ? process.env.HOME : "./linux";
  let srcRootDir = isReverse ? "./linux" : process.env.HOME;
  return {
    path: resolve(srcRootDir, relPath),
    dir: resolve(srcRootDir, path.dirname(relPath)),
    linkDir: resolve(linksRootDir, path.dirname(relPath)),
    link: resolve(linksRootDir, relPath),
    relPath,
  };
}

function isIncludedFile(p) {
  return !p.startsWith("!") && !isIgnored(p);
}

function isIgnored(pathToCheck) {
  return (
    patterns.findIndex(function (ignorePattern) {
      if (ignorePattern[0] !== "!") return false; // it is a pattern to include files
      ignorePattern = resolve(ignorePattern.slice(1)); // get rid of "!"
      pathToCheck = resolve(pathToCheck);
      if (ignorePattern === pathToCheck) return true; // exact match
      // ignore sub files and directories if the ignore pattern is a directory
      if (!fs.existsSync(ignorePattern)) return false;
      if (
        fs.statSync(ignorePattern).isDirectory() &&
        !path.relative(ignorePattern, pathToCheck).startsWith("..")
      )
        return true;
    }) > -1
  );
}

function error(...msgs) {
  console.error(...msgs);
  errorOccured = true;
}

if (errorOccured) process.exit(1);

!isDry && linkDirs.forEach((d) => fs.mkdirSync(d, { recursive: true }));
relativePaths.forEach((f) => console.log(f));
