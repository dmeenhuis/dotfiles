#!/usr/bin/env node

var fs = require("fs"),
  print = require("./index.js"),
  opts = require("yargs")
  .options({
    help: {},
    version: {},
    ascii: {},
    format: {
      default: "#[fg=default]mem [#[fg=:color]:spark#[fg=default]] :percent"
    },
    width: {
      default: 10
    },
    tty: {
      default: process.stdout.isTTY
    },
    color: {
      default: true
    }
  })
  .boolean("help")
  .boolean("version")
  .boolean("ascii")
  .boolean("tty")
  .boolean("color"),
  argv = opts.parse(process.argv);

var fmt = false;

if (argv["version"] || argv["v"]) {
  console.log(require("./package.json").version);
  process.exit();
}

if (argv["help"]) {
  return fs
    .createReadStream(__dirname + "/usage.txt")
    .pipe(process.stdout)
    .on("close", () => {
      process.exit(1);
    });
}

if (argv["ascii"]) {
  argv["format"] =
    ":currentBytes / :totalBytes [#[fg=:color]:bar#[fg=default]] :percent";
}

if (argv["format"]) {
  fmt = argv["format"];
}

print(fmt, argv["width"], argv["tty"], argv["color"]);
