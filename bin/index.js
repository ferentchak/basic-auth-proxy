require("coffee-script");
fs = require("fs")
proxy = require("./../lib/proxy");
path = require("path");
currentDirectory = process.cwd();

var configFileLocation = path.join(currentDirectory, "config.json");
var config = JSON.parse(fs.readFileSync(configFileLocation));
proxy(config);