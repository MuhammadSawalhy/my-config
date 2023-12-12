const fs = require("fs");
const path = require("path");
const source = process.argv[2];
const patterns = process.argv.slice(3);
let errorOccured = false;

main();

function main() {
  const relativePaths = processPatterns(patterns);
  if (errorOccured) process.exit(1);
  relativePaths.forEach((f) => console.log(f));
}

/**
 * Get relative paths to the source files that match the patterns
 * @param {String[]} patterns gitignore-like patterns
 * @returns {String[]}
 */
function processPatterns(patterns) {
  const relativePaths = [];

  patterns.reverse();

  while (patterns.length) {
    const p = patterns.pop();
    if (!isIncludedFile(p)) continue;
    const linkingInfo = getFileInfo(p);
    if (!fs.existsSync(linkingInfo.fullPath)) continue;
    const stats = fs.lstatSync(linkingInfo.fullPath);

    // if it is file
    if (stats.isFile()) {
      relativePaths.push(linkingInfo.relPath);
    } else if (stats.isDirectory()) {
      // it is directory
      let content = fs
        .readdirSync(linkingInfo.fullPath, { withFileTypes: true })
        .map((dirent) =>
          path.relative(source, path.resolve(linkingInfo.fullPath, dirent.name))
        )
        .filter(isIncludedFile);
      patterns.push(...content);
    } else if (stats.isSymbolicLink()) {
      console.error(`skip symlink: ${linkingInfo.relPath}`);
    }else {
      error(`unkown file type: ${linkingInfo.relPath}`);
    }
  }

  return relativePaths;
}

function getFileInfo(relPath) {
  return {
    fullPath: path.resolve(source, relPath),
    relPath,
  };
}

function isIncludedFile(p) {
  return true;
  return !p.startsWith("!") && !isIgnored(p);
}

function isIgnored(pathToCheck) {
  return (
    patterns.findIndex(function (ignorePattern) {
      if (ignorePattern[0] !== "!") return false; // it is a pattern to include files
      ignorePattern = path.resolve(source, ignorePattern.slice(1)); // get rid of "!"
      pathToCheck = path.resolve(source, pathToCheck);
      if (ignorePattern === pathToCheck) return true; // exact match
      // 1. ignore sub files and directories if the ignore pattern is a directory
      // 2. if it is a directory and dosn't exists, then this file will be skipped before reaching here
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
