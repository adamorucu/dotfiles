local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local colors = require("colors")
local dpi = require("beautiful.xresources").apply_dpi

local theme = require("ui.theme")

local date = wibox.widget.textclock(" %d.%m.%Y")
local clock = wibox.widget.textclock(" %H:%M")

local function create_layoutbox(s)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end)
    ))
end

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

-- Battery
local baticon = wibox.widget.textbox('')
function theme.update_baticon(icon)
	baticon:set_markup(
		string.format('<span color="%s" font="'..theme.icon_font..'">%s</span>', theme.clr.blue, icon)
	)
end

local bat = wibox.widget.textbox('')
function theme.update_battery()
	awful.spawn.easy_async_with_shell(
	[[bash -c "echo $(acpi|awk '{split($0,a,", "); print a[2]}')"]],
	function(stdout)
		if stdout == '' then
			bat:set_markup('<span color="'..theme.clr.blue..'" font="'..theme.widget_font..'"> N/A</span>')
			return
		end
		stdout = stdout:gsub("%%", ""):match("^%s*(.-)%s*$")
		percent = tonumber(stdout)
		if percent <= 5 then
			theme.update_baticon('')
		elseif percent <= 25 then
			theme.update_baticon('')
		elseif percent >= 25 and percent <= 75 then
			theme.update_baticon('')
		elseif percent < 100 then
			theme.update_baticon('')
		else
			theme.update_baticon('')
		end
			
		bat:set_markup('<span color="'..theme.clr.blue..'" font="'..theme.widget_font..'"> ' ..stdout.."%</span> ")
	end)
end
theme.update_battery()

local battery =
	{
		layout = wibox.layout.fixed.horizontal,
		half_spr,
		baticon,
		bat,
		half_spr,
	}

-- Bar
awful.screen.connect_for_each_screen(function(s) 
    create_layoutbox(s)
    create_taglist(s)

    s.mywibox = awful.wibox({ 
      screen = s, 
      width = s.geometry.width, -- - beautiful.useless_gap * 4,
      height = beautiful.wibar_height / 2
    })

    s.mywibox:setup {
        layout = wibox.container.background,
        bg = colors.primary,
        {
            layout = wibox.layout.align.horizontal,
            
            -- Left
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

            -- Right
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    clock,
                    battery,
                    date,
                },
                widget = wibox.container.margin,
                top = dpi(5),
                bottom = dpi(5),
                right = dpi(5),
                left = dpi(5)
            },
        }
    }

end)
