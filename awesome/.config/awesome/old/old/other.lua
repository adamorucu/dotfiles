local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local date = wibox.widget.textclock(" %d.%m.%Y")
local clock = wibox.widget.textclock(" %H:%M")

local taglist_buttons = gears.table.join(
    awful.button(
        { }, 1, 
        function(t) t:view_only() end
    ),

    awful.button({ modkey }, 1, 
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),

    awful.button(
        { }, 3, 
        awful.tag.viewtoggle
    ),

    awful.button(
        { modkey }, 3, 
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    )
)

local function create_taglist(s)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }
end

return create_taglist

awful.screen.connect_for_each_screen(function(s)

    create_layoutbox(s)
    create_taglist(s)

    -- Add padding equal to bar top padding
    s.padding = {
      top = beautiful.useless_gap * 2
    } 

    -- Create the wibox
    s.mywibox = awful.wibox({ 
      screen = s, 
      width = s.geometry.width - beautiful.useless_gap * 4,
      height = beautiful.wibar_height
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.container.background,
        bg = colors.primary,
        {
          layout = wibox.layout.align.horizontal,
          -- Left widgets
          { 
              layout = wibox.layout.fixed.horizontal,
              {
                layout = wibox.container.background,
                bg = colors.secondary,
                {
                  layout = wibox.container.margin,
                  left = beautiful.taglist_spacing,
                  right = beautiful.taglist_spacing,
                  s.mytaglist
                }
              },
              {
                layout = wibox.container.background,
                fg = colors.secondary,
                bg = colors.accent_dark_2,
                seperator_left
              },
              {
                layout = wibox.container.background,
                fg = colors.accent_dark_2,
                bg = colors.accent_dark_1,
                seperator_left
              },
              {
                layout = wibox.container.background,
                fg = colors.accent_dark_1,
                bg = colors.accent,
                seperator_left
              },
              {
                layout = wibox.container.background,
                fg = colors.accent,
                seperator_left
              }
          },
          nil,
          -- Right widgets
          { 
              layout = wibox.layout.fixed.horizontal,
              {
                layout = wibox.container.background,
                fg = colors.accent,
                seperator_right
            
              },
              {
                layout = wibox.container.background,
                bg = colors.accent,
                fg = colors.accent_dark_1,
                seperator_right
            
              },
              {
                layout = wibox.container.background, 
                bg = colors.accent_dark_1,
                fg = colors.text,
                {
                  layout = wibox.layout.fixed.horizontal,
                  {
                    layout = wibox.container.margin,
                    left = beautiful.taglist_spacing,
                    right = beautiful.taglist_spacing / 2,
                date 
            
                  },
                  {
                    layout = wibox.container.background,
                    fg = colors.accent_dark_2,
                    seperator_right
                
                  }
                }
              },
              {
                layout = wibox.container.background,
                bg = colors.accent_dark_2,
                fg = colors.text,
                {
                  layout = wibox.layout.fixed.horizontal,
                  {
                    layout = wibox.container.margin,
                    left = beautiful.taglist_spacing,
                    right = beautiful.taglist_spacing / 2,
                    clock
                  },
                  {
                    layout = wibox.container.background,
                    fg = colors.secondary,
                    seperator_right
                
                  }
                }
                
              },
              {
                layout = wibox.container.background,
                bg = colors.secondary,
                {
                  layout = wibox.container.margin,
                  margins = 8,
                  s.mylayoutbox
                }
              }
          },
        }
    }

    s.mywibox.x = s.geometry.x + beautiful.useless_gap * 2
    s.mywibox.y = s.geometry.y + beautiful.useless_gap * 2
end)
