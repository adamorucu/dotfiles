local helpers = require "helpers"
return function(s)
  local awful = require "awful"
  local bling = require "modules.bling"
  local gears = require "gears"
  local wibox = require "wibox"
  bling.widget.tag_preview.enable {
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
      awful.placement.top_left(c, {
        margins = {
          top = 50,
          left = 20,
        },
      })
    end,
  }
  return awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({}, 1, function(t)
        t:view_only()
      end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
      end),
      awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
      end),
    },
    style = {
      shape = helpers.squircle(1.3, 0),
    },
    widget_template = {
      {
        {
          id = "text_role",
          widget = wibox.widget.textbox,
        },
        left = 7,
        right = 7,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c3, index, objects) --luacheck: no unused args
        self:connect_signal("mouse::enter", function()
          if #c3:clients() > 0 then
            awesome.emit_signal("bling::tag_preview::update", c3)
            awesome.emit_signal("bling::tag_preview::visibility", s, true)
          end
        end)
        self:connect_signal("mouse::leave", function()
          awesome.emit_signal("bling::tag_preview::visibility", s, false)

          if self.has_backup then
            self.bg = self.backup
          end
        end)
      end,
    },
  }
end
