local wezterm = require 'wezterm';

return {
    front_end = "OpenGL",
    font = wezterm.font({'Roboto Mono', stretch="UltraCondensed", weight="Regular"}),
    font_size = 12,
    colors = {
        foreground = "#000000",
        background = "#F1EBDD",
        cursor_bg = "#000000",
        cursor_fg = "#000000",
        cursor_border = "#000000",
        selection_fg = "#F1EBDD",
        selection_bg = "#000000",
        scrollbar_thumb = "#000000",
        split = "#6E645E",
        ansi = {"#000000", "#de3d35", "#3e953a", "#d2b67b", "#2f5af3", "#950095", "#3e953a", "#bbbbbb"},
        brights = {"#000000", "#de3d35", "#3e953a", "#d2b67b", "#2f5af3", "#950095", "#3e953a", "#ffffff"},
    },
    window_padding = {
      left = 40,
      right = 40,
      top = 40,
      bottom = 40,
    },
    enable_tab_bar = false,
    default_cursor_style = "BlinkingUnderline",
  }