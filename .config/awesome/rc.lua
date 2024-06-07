-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
menubar = require("menubar")
hotkeys_popup = require("awful.hotkeys_popup")
dpi = require("beautiful.xresources").apply_dpi

-- awesome-wm-widgets
cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
volume_widget = require("awesome-wm-widgets.volume-widget.volume")
calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- bling - 6 макетов, модули выделения при наведении, вкладок, генерируемых обоев, глотания окон, динамический расширенный менеджер обоев
bling = require("bling")

-- radical - упрощенное создание разных меню в виде 6 макетов (6 лет назад?)
-- radical = require("radical")

-- vicious - упрощенное создание виджетов, поддерживает таймеры и паузу виджетов, имеет 30 видов виджетов
vicious = require("vicious")

-- yoru - конфигурация, но содержащая 7 уникальных виджетов не на панель, можно брать, но не экспортировать

-- Подсветка окон при переключении
bling.module.flash_focus.enable()
-- dpi = beautiful.xresources.apply_dpi()

-- require("tag_preview")

require("error")

require("user_prefs")

-- Scrathpad
require("spad")

require("layouts")

require("ui")

require("keys")

require("rules")

require("signals")

require("garbage")

-- Autostart
awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/autostart.sh")

-- потрогать vicious, разобрать yoru, dashboard
-- сделать первый стол: понять, как сделаны виджеты на столе https://github.com/TanvirOnGH/awesomewm-config
-- виджет на основе progress
-- Скрипты в bin
-- Найди layout-machi
-- ephoto photoflare pinta mirage


-- scratchpad, dashboard, broot
