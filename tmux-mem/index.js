var fs = require("fs"),
  bytes = require("bytes"),
  spark = require("textspark"),
  colors = require("tmux-colors");

const escapeRegExp = string => string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");

function bar(opts) {
  var ratio = opts.current / opts.total,
    width = opts.width || 10,
    complete = Array(Math.round(width * ratio)).join("="),
    incomplete = Array(width - complete.length).join(" "),
    result = opts.format;

  result = result.replace(":bar", complete + incomplete);

  return Object.keys(opts)
    .sort((a, b) => b.length - a.length) // sort so that we match the longest strings first
    .filter(key => key != "bar" && key != "format")
    .reduce((acc, key) => acc.replace(new RegExp(escapeRegExp(`:${key}`), "g"), opts[key]), result);
}

function meminfo() {
  var data = fs.readFileSync("/proc/meminfo").toString();

  return data.split(/\n/g).reduce((acc, line) => {
    line = line.split(":");

    if (line.length < 2) {
      return acc;
    }

    const [key, value] = line;

    acc[key] = parseInt(value.trim(), 10) * 1000; // convert to bytes

    return acc;
  }, {});
}

module.exports = (fmt, width, tty, enableColor) => {
  var memInfo = meminfo();

  var free = memInfo["MemFree"] + memInfo["Buffers"] + memInfo["Cached"],
    total = memInfo["MemTotal"],
    used = total - free,
    percent = (used / total) * 100,
    color,
    colorsList = ["red", "yellow", "green"];

  [75, 50, 25].some((threshold, i) => {
    color = colorsList[i];
    return percent > threshold;
  });

  console.log(
    colors(
      bar({
        format: fmt,
        current: used,
        currentBytes: bytes(used),
        total: total,
        totalBytes: bytes(total),
        spark: spark([0, percent, 100])[1],
        color: color,
        percent: `${percent.toFixed(0)}%`,
        width: width || 10
      }), {
        tty: tty || process.stdout.isTTY,
        color: enableColor
      }
    )
  );
};
