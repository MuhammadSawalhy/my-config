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

let patterns = process.argv.slice(2);
let relPaths = new Set();
let linkDirs = new Set();
let isDry = process.env.DRY === "1";
let isForce = process.env.FORCE === "1";
let isReverse = process.env.REVERSE === "1";
let isFill = process.env.FILL === "1";

function resolve(...p) {
  let homeRootPath = p.find((_) => _.startsWith("~"));
  if (homeRootPath)
    return path.resolve(process.env.HOME, homeRootPath.slice(2));
  return path.resolve(...p);
}

function isIgnored(p) {
  return (
    patterns.findIndex(function (ignorePattern) {
      if (ignorePattern[0] !== "!") return false; // it is a pattern to include files
      ignorePattern = resolve(ignorePattern.slice(1)); // get rid of "!"
      p = resolve(p);
      if (ignorePattern === p) return true; // exact match
      // ignore sub files and directories if the ignore pattern is a directory
      if (!fs.existsSync(ignorePattern)) return false;
      if (
        fs.statSync(ignorePattern).isDirectory() &&
        !path.relative(ignorePattern, p).startsWith("..")
      )
        return true;
    }) > -1
  );
}

function filter(p) {
  return !p.startsWith("!") && !isIgnored(p);
}

function handleFile(f) {
  let relPath = f;
  if (!isReverse) {
    relPath = resolve(f); // it stats with ~, resolve it to get the full path
    relPath = path.relative(process.env.HOME, relPath);
    if (relPath.startsWith(".."))
      throw "patterns should be inside the $HOME directory";
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

while (patterns.length) {
  let p = patterns.shift();
  if (filter(p)) {
    let linkingData = handleFile(p);
    if (!fs.existsSync(linkingData.path)) {
      console.error("source path doesn't exist: " + linkingData.path);
      process.exit(1);
    }

    // if it is file
    if (fs.statSync(linkingData.path).isFile()) {
      if (fs.existsSync(linkingData.link)) {
        if (isFill) continue; // skip this file as it exists
        if (!isForce) {
          console.error(
            "targetted link will overwrite exsiting file: " + linkingData.link
          );
          process.exit(1);
        }
      }
      relPaths.add(linkingData.relPath);
      linkDirs.add(linkingData.linkDir);
    }

    // it is directory
    else {
      let content = fs
        .readdirSync(linkingData.path, { withFileTypes: true })
        .map((dirent) => resolve(linkingData.path, dirent.name))
        .filter(filter);
      patterns.unshift(...content); // put the at the beginning of our patterns, FIFO
    }
  }
}

!isDry && linkDirs.forEach((d) => fs.mkdirSync(d, { recursive: true }));
relPaths.forEach((f) => console.log(f));
// console.log(Array.from(relPaths).join("\n"));

