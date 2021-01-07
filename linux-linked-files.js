const fs = require("fs");
const path = require("path");
let patterns = process.argv.slice(2);
let filter =
  (p) =>
  !p.startsWith("!") &&
  !patterns.find(_p=>_p.startsWith("!") && path.resolve(_p.slice(1)) === p);

let files = new Set();
let dirs = new Set();
let isDry = process.env.DRY === '1';

function addFile(f) {
  let rel = path.relative(process.env.HOME, f);
  if(rel.startsWith("../")) throw "patterns should be inside the $HOME directory";
  dirs.add(path.resolve('./linux', path.dirname(rel)));
  files.add(rel);
}

while (patterns.length) {
  let p = patterns.shift();
  if (filter(p)) {
    if (!fs.existsSync(p)) throw "path doesn't exist: " + p;
    if (fs.statSync(p).isFile()) addFile(p);
    else /* it is directory */ {
      let content = fs.readdirSync(p, { withFileTypes: true })
        .map(dirent=>path.resolve(p, dirent.name)).filter(filter);
      patterns = patterns.concat(content);
    }
  }
}

!isDry && dirs.forEach(d=>fs.mkdirSync(d,{recursive:true}));
console.log(Array.from(files).join("\n"));

