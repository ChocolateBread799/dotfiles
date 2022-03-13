local wezterm = require 'wezterm';

return {
    front_end = "OpenGL",
    font = wezterm.font({'SFMono Nerd Font', stretch="UltraCondensed", weight="Meidum"}),
    font_size = 14,
    colors = {
      foreground = "#3e3e3e",
      background = "#ffffff",
      cursor_bg = "#3f3f3f",
      cursor_border = "#3f3f3f",
      cursor_fg = "#ffffff",
      selection_bg = "#a9c1e2",
      selection_fg = "#535353",
        split = "#6E645E",
        ansi = {"#3e3e3e","#970b16","#07962a","#f8eec7","#003e8a","#e94691","#89d1ec","#ffffff"},
        brights = {"#666666","#de0000","#87d5a2","#f1d007","#2e6cba","#ffa29f","#1cfafe","#ffffff"}
    },
    window_padding = {
      left = 30,
      right = 20,
      top = 20,
      bottom = 20,
    },
    window_close_confirmation = "NeverPrompt",
    enable_tab_bar = false,
    default_cursor_style = "BlinkingUnderline",
  }
