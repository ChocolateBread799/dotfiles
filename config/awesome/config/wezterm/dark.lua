local wezterm = require 'wezterm';

return {
    front_end = "OpenGL",
    font = wezterm.font({'SFMono Nerd Font', stretch="UltraCondensed", weight="Meidum"}),
    font_size = 14,
    colors = {
      foreground = "#ffffff",
      background = "#161719",
      cursor_bg = "#c9d1d9",
      cursor_border = "#c9d1d9",
      cursor_fg = "#ffffff",
      selection_bg = "#3b5070",
      selection_fg = "#ffffff",      
        split = "#6E645E",
        ansi = {"#000000","#f78166","#56d364","#e3b341","#6ca4f8","#db61a2","#2b7489","#ffffff"},
        brights = {"#4d4d4d","#f78166","#56d364","#e3b341","#6ca4f8","#db61a2","#2b7489","#ffffff"}
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
