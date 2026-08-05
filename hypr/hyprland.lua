-- programs
terminal = "kitty"
fileManager = "pcmanfm"
menu = "rofi --show drun"


-- auto start
hl.on("hyprland.start", function ()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("mako")
  hl.exec_cmd("~/.config/waybar/launch.sh")
  hl.exec_cmd("hyprpaper")
end)


-- env
hl.env("LIBVA_DRIVER_NAME","nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("NVD_BACKEND", "direct")

hl.env("ELECTRON_OZONE_PLATFORM_HINT","auto")

hl.env("XCURSOR_SIZE","24")
hl.env("HYPRCURSOR_SIZE","24")


-- for libadwaita gtk4 apps you can use this command:
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"")   -- for GTK4 apps

-- for gtk3 apps you need to install adw-gtk3 theme (in arch linux sudo pacman -S adw-gtk-theme)
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme \"adw-gtk3-dark\"")   -- for GTK3 apps


require ("style")
require ("input")
require ("binds")
require ("desktop")
