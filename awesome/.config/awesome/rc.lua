pcall(require, "luarocks.loader")
require("awful.autofocus")

local beautiful = require("beautiful")
beautiful.init(require("ui.theme"))

modkey = "Mod4"

require("keys")
require("ui")
require("layouts")
require("rules")
require("tags")
