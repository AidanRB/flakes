-- monitors
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output = "DP-1",
  mode = "preferred",
  position = "1920x0",
  scale = 1,
})
hl.monitor({
  output = "DP-2",
  mode = "1920x1080@239.76Hz",
  position = "0x0",
  scale = 1,
})
hl.monitor({
  output = "HDMI-A-1",
  mode = "preferred",
  position = "-1920x0",
  scale = 1,
})

-- autostart
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic-2 24")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("elephant")
  hl.exec_cmd("walker --gapplication-service")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("kdeconnect-indicator")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("discord")
  hl.exec_cmd("openrgb --startminimized")
end)

-- environment
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic-2")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- config
-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 0,
    resize_on_border = true,
    allow_tearing = true,
    layout = dwindle,
    snap = {
      -- note to future self: it's for the floating work rdp window
      enabled = true,
    },
  },

  decoration = {
    rounding = 10,

    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      vibrancy = 0.1696,
    },

    shadow = {
      enabled = true,
      range = 10,
      render_power = 3,
      color = "rgba(808080ee)",
      color_inactive = "rgba(1a1a1aee)",
    },
  },

  input = {
    kb_layout = "us",
    kb_options = "compose:caps",
    numlock_by_default = true,

    accel_profile = "flat",
    follow_mouse = 1,
  },

  group = {
    groupbar = {
      font_family = "Montserrat Semibold",
      font_weight_active = 700,
      font_size = 12,
      indicator_height = 20,
      indicator_gap = -17,
      rounding = 6,
      round_only_edges = true,
      text_color = "rgb(ffffff)",
      text_color_inactive = "rgba(ffffffaa)",
      col = {
        active = "rgba(1c00abaa)",
        inactive = "rgba(00000044)",
      },
    },
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    background_color = "rgb(000000)",
    focus_on_activate = true, -- notification fix
  },

  cursor = {
    default_monitor = "DP-2",
  },

  -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/#config
  dwindle = {
    preserve_split = true,
    special_scale_factor = 0.9,
    precise_mouse_move = true,
  },
})

-- animations
hl.curve("easeOutQuint", {
  type = "bezier",
  points = {{0.23, 1}, {0.32, 1}},
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 4.79,
  bezier = "easeOutQuint",
})
hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 7,
  bezier = "easeOutQuint",
  style = "slide",
})
hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "easeOutQuint",
  style = "slide bottom",
})
hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 1.5,
  bezier = "linear",
  style = "popin",
})
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 1.94,
  bezier = "easeOutQuint",
  style = "slidefadevert 25%",
})

-- smart gaps
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/#smart-gaps
hl.workspace_rule({
  workspace = "w[tv1]",
  gaps_out = 0,
  gaps_in = 0,
})
hl.workspace_rule({
  workspace = "f[1]",
  gaps_out = 0,
  gaps_in = 0,
})
hl.window_rule({
  match = {
    float = false,
    workspace = "w[tv1]",
  },
  border_size = 0,
})
hl.window_rule({
  match = {
    float = false,
    workspace = "w[tv1]",
  },
  rounding = 0,
})
hl.window_rule({
  match = {
    float = false,
    workspace = "f[1]",
  },
  border_size = 0,
})
hl.window_rule({
  match = {
    float = false,
    workspace = "f[1]",
  },
  rounding = 0,
})

-- binds: custom window management
-- https://wiki.hypr.land/Configuring/Basics/Binds/
hl.bind("SUPER + GRAVE", hl.dsp.group.toggle())
hl.bind("SUPER + TAB", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + TAB", hl.dsp.group.prev())
hl.bind("SUPER + q", hl.dsp.window.close())
hl.bind("SUPER + v", hl.dsp.window.float())
hl.bind("SUPER + j", hl.dsp.layout("rotatesplit"))
hl.bind("SUPER + F11", hl.dsp.window.fullscreen())

-- binds: focus
hl.bind("SUPER + LEFT", hl.dsp.focus({
  direction = "left",
}))
hl.bind("SUPER + RIGHT", hl.dsp.focus({
  direction = "right",
}))
hl.bind("SUPER + UP", hl.dsp.focus({
  direction = "up",
}))
hl.bind("SUPER + DOWN", hl.dsp.focus({
  direction = "down",
}))

-- https://github.com/hyprwm/Hyprland/blob/203a121537d0868bd4d8258b58861ca970483157/example/hyprland.lua#L275
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0

  -- binds: focus a numbered workspace
  hl.bind("SUPER + " .. key, hl.dsp.focus({
    workspace = i,
  }))

  -- binds: move current window to a numbered workspace
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({
    workspace = i,
  }))
end

-- binds: move workspaces to another monitor
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.workspace.move({
  monitor = "l",
}))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.workspace.move({
  monitor = "r",
}))

-- binds: special workspace
hl.bind("SUPER + s", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + s", hl.dsp.window.move({
  workspace = "magic",
}))

-- binds: mouse window movement/resizing
-- https://wiki.hypr.land/Configuring/Basics/Binds/#mouse-binds
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), {
  mouse = true,
})
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), {
  mouse = true,
})

-- binds: multimedia
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), {
  repeating = true,
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
  repeating = true,
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
-- these don't work on a desktop, need to replace
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"))

-- binds: launchers
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("walker"))
hl.bind("SUPER + SHIFT + v", hl.dsp.exec_cmd("walker --provider clipboard"))
hl.bind("SUPER + l", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + t", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + CTRL + b", hl.dsp.exec_cmd("brave"))
hl.bind("SUPER + CTRL + d", hl.dsp.exec_cmd("discord"))
hl.bind("SUPER + CTRL + s", hl.dsp.exec_cmd("steam"))
hl.bind("SUPER + CTRL + c", hl.dsp.exec_cmd("code"))
hl.bind("SUPER + CTRL + m",
  hl.dsp.exec_cmd("brave --profile-directory=Default --app-id=cinhimbnkkaeohfgghhklpknlkffjgod"))
hl.bind("SUPER + CTRL + y",
  hl.dsp.exec_cmd("brave --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml"))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("walker --provider menus power"))
hl.bind("PRINT", hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=sway flameshot gui"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("pkill -SIGUSR1 -f gpu-screen-recorder"))
hl.bind("SUPER + f", hl.dsp.exec_cmd("nautilus"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("speedcrunch"))
-- log out
hl.bind("SUPER + m", hl.dsp.exec_cmd("uwsm stop"))

-- window rules
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
hl.window_rule({
  -- Fix some dragging issues with XWayland
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})

hl.window_rule({
  match = {
    title = "flameshot",
  },
  no_anim = true,
  float = true,
  move = {-1920, 0},
  size = {5120, 1080},
  pin = true,
  monitor = 0,
  rounding = 0,
})

hl.window_rule({
  match = {
    title = "flameshot-pin",
  },
  no_anim = true,
  float = true,
  rounding = 0,
})

hl.window_rule({
  match = {
    title = "W101A-AidBennett",
    class = "org.remmina.Remmina",
  },
  float = true,
  pin = true,
  move = {-1920, 0},
  size = {3840, 1080},
  monitor = 0,
  rounding = 0,
})

hl.window_rule({
  match = {
    class = "discord",
  },
  monitor = "DP-3",
})

hl.window_rule({
  name = "steam games fullscreen on main monitor",
  match = {
    class = "^steam_app_.*",
  },
  fullscreen = true,
  monitor = "DP-2",
})

hl.window_rule({
  match = {
    class = "org.speedcrunch.",
  },
  float = true,
  size = {300, 300},
})

hl.window_rule({
  match = {
    class = "com.wiremix",
  },
  float = true,
  size = {600, 500},
  move = {"monitor_w-620", 50},
})

-- layer rules (basically transitions)
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules
hl.layer_rule({
  name = "waybar entry",
  match = {
    namespace = "waybar",
  },
  animation = "slide top",
})

hl.layer_rule({
  name = "wallpaper entry",
  match = {
    namespace = "hyprpaper",
  },
  animation = "fade 1",
})
