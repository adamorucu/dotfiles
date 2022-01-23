local gears = require("gears")

root.keys(gears.table.join(
  require("keys.global.tag"),
  require("keys.global.global")
))
