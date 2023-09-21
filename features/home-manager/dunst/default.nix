{ pkgs, ... }:
{
  home.packages = with pkgs; [ libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = 350;
        offset = "20x20";
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 150;
        progress_bar_max_width = 400;
        indicate_hidden = true;
        shrink = false;
        separator_height = 2;
        padding = 15;
        horizontal_padding = 15;
        text_icon_padding = 15;
        frame_width = 1;
        frame_color = "#ffa500";
        transparency = 20;
        corner_radius = 5;
        separator_color = "frame";
        sort = true;
        idle_threshold = 120;
        font = "JetBrains Mono Nerd Font Medium 12";
        line_height = 0;
        markup = "full";
        format = "<span weight='bold'>%s</span>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = false;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 32;
        sticky_history = true;
        history_length = 20;
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      experimental = {
        per_monitor_dpi = false;
      };
      urgency_low = {
        background = "#000000";
        foreground = "#ffffff";
        timeout = 3;
      };
      urgency_normal = {
        background = "#000000";
        foreground = "#ffffff";
        timeout = 5;
      };
      urgency_critical = {
        background = "#181825AA";
        foreground = "#ffffff";
        frame_color = "#ff0000";
        timeout = -1;
        format = "<b>%s</b>\\n%b";
      };
    };
  };
}
