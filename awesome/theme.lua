---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme_dir = "/home/ttucker/thinkpad/awesome/theme/"

local solarized = {}

solarized.base03    = "#002b36"
solarized.base02    = "#073642"
solarized.base01    = "#586e75"
solarized.base00    = "#657b83"
solarized.base0     = "#839496"
solarized.base1     = "#93a1a1"
solarized.base2     = "#eee8d5"
solarized.base3     = "#fdf6e3"
solarized.yellow    = "#b58900"
solarized.orange    = "#cb4b16"
solarized.red       = "#dc322f"
solarized.magenta   = "#d33682"
solarized.violet    = "#6c71c4"
solarized.blue      = "#268bd2"
solarized.cyan      = "#2aa198"
solarized.green     = "#859900"

solarized.term = {}
solarized.term.green    = "#5f8700"
solarized.term.cyan     = "#00afaf"
solarized.term.blue     = "#0087ff"
solarized.term.brmagenta= "#5f5faf"
solarized.term.magenta  = "#af005f"
solarized.term.red      = "#d70000"
solarized.term.brred    = "#d75f00"
solarized.term.yellow   = "#af8700"
-- Grays:
solarized.term.brwhite  = "#ffffd7"
solarized.term.white    = "#d7d7af"
solarized.term.brcyan   = "#8a8a8a"
solarized.term.brblue   = "#808080"
solarized.term.bryellow = "#585858"
solarized.term.brgreen  = "#4e4e4e"
solarized.term.black    = "#262626"
solarized.term.brblack  = "#1c1c1c"

local theme = {}

theme.font          = "Anonymous Pro 10"

theme.bg_normal     = solarized.term.brblack
theme.bg_focus      = solarized.term.black
theme.bg_urgent     = solarized.term.bryellow
theme.bg_minimize   = solarized.term.brgreen
theme.bg_systray    = solarized.term.brgreen

theme.fg_normal     = solarized.term.brgreen
theme.fg_focus      = solarized.term.brcyan
theme.fg_urgent     = solarized.violet
theme.fg_minimize   = "#c5c8c6"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0.5)
--theme.border_normal = "#000000"
theme.border_normal = solarized.term.black
--theme.border_focus  = "#373b41"
theme.border_focus  = solarized.term.bryellow
theme.border_marked = "#cc6666"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.taglist_bg_focus = "#282a2e"
theme.tasklist_bg_focus = "#282a2e"
theme.tasklist_bg_normal = "#222222"

-- XXX Work more on these colors later:
theme.taglist_bg_focus = solarized.term.brgreen
theme.taglist_fg_focus = solarized.orange
theme.tasklist_bg_focus = solarized.brblack
theme.tasklist_bg_normal = solarized.black

-- Generate taglist squares:
local taglist_square_size = dpi(6)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."zenburn/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."zenburn/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."zenburn/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."zenburn/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."zenburn/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."zenburn/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."zenburn/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."zenburn/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."zenburn/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."zenburn/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."zenburn/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."zenburn/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."zenburn/titlebar/maximized_focus_active.png"

-- theme.wallpaper = themes_path.."zenburn/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
