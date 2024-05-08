return function(theme)
  --local accent = theme.mauve
  local accent = '${accent}' -- replaced later in python script

  return {
    bg_bar_main = '#ff'..theme.base,
    tint_popup_bg = '#ff'..theme.mantle,
    tint_progress_bar = '#ff'..accent,
    tint_tab_indicator_selected = '#ff'..accent,
    tint_icon_signs = '#ff'..theme.maroon,

    syntax_keyword = '#ff'..theme.mauve,
    syntax_symbol = '#ff'..theme.peach,
    syntax_comment = '#ff'..theme.overlay0,
    syntax_attr = '#ff'..theme.sapphire,

    text_button = '#dc'..theme.text,
    text_edit_box = '#ff'..theme.text,
    text_grid_primary = '#ff'..theme.text,

    text_grid_secondary = '#ff'..theme.subtext1,
    text_bar_main_secondary = '#ff'..theme.subtext1,

    text_popup_primary = '#e6'..theme.text,
    text_popup_secondary = '#96'..theme.text,

    tint_bar_main_icons = '#ff'..theme.subtext1,
    tint_popup_controls = '#ff'..accent,

    tint_progress_track = '#ff'..theme.surface2,
    highlight_bar_main_buttons = '#ff'..theme.overlay0,
    tint_page_separator = '#ff'..theme.base,
    highlight_popup_list_item = '#ff'..theme.surface0,

    text_filter_box_hint = '#ff'..theme.subtext0,

    text_link_pressed = '#ff'..theme.text,

    text_edit_selection_background = '#64'..accent,

    highlight_visited_folder = '#0a'..theme.subtext1,
    tint_folder = '#ff'..theme.subtext0,
    highlight_grid_item = '#80'..accent,

    text_breadcrumb_selected = '#ff'..theme.text,
    text_breadcrumb = '#ff'..theme.subtext1,
    syntax_string = '#ff'..theme.text,
    tint_popup_icons = '#ff'..theme.subtext1,
    tint_bar_tools_icons = '#ff'..theme.subtext1,
    tint_notification_buttons = '#ff'..theme.surface0,
    text_edit_selection_foreground = '#ff'..theme.text,
  }
end