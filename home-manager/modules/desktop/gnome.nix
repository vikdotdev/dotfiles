{ config, pkgs, ... }:

let
  # Desktop entry template for hiding applications
  hiddenDesktopEntry = ''
    [Desktop Entry]
    Hidden=true
  '';
in
{
  # GNOME-specific packages
  home.packages = with pkgs; [
    # GNOME Extensions
    gnomeExtensions.go-to-last-workspace
    
    # GNOME utilities
    pavucontrol    # PulseAudio volume control GUI (GNOME audio management)
  ];

  # GNOME configuration files
  home.file = {
    ".config/gtk-3.0/settings.ini".source = ../../configs/gnome/settings3.ini;
    ".config/gtk-3.0/gtk.css".source = ../../configs/gnome/gtk3.css;
    ".config/gtk-4.0/gtk.css".source = ../../configs/gnome/gtk4.css;
    ".config/autostart/windows.desktop".source = ../../configs/gnome/windows.desktop;
    ".local/share/pixmaps/windows.png".source = ../../configs/gnome/windows.png;
    
    # Hide desktop entries for unwanted applications
    ".local/share/applications/htop.desktop".text = hiddenDesktopEntry;
    ".local/share/applications/xterm.desktop".text = hiddenDesktopEntry;
    ".local/share/applications/org.gnome.Terminal.desktop".text = hiddenDesktopEntry;
    ".local/share/applications/emacsclient.desktop".text = hiddenDesktopEntry;
  };

  # GNOME dconf settings
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer" "variable-refresh-rate"];
      overlay-key = "";
      dynamic-workspaces = false;
    };
    
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = 32;
      delay = 250;
    };
    
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
      focus-mode = "click";
    };
    
    "org/gnome/desktop/wm/keybindings" = {
      raise = [""];
      minimize = [""];
      switch-to-workspace-left = [""];
      switch-to-workspace-right = [""];
      move-to-workspace-left = [""];
      move-to-workspace-right = [""];
      begin-move = [""];
      always-on-top = [""];
      toggle-on-all-workspaces = [""];
      begin-resize = ["<Super>r"];
      toggle-fullscreen = ["<Super>f"];
      switch-windows = [""];
      switch-windows-backward = [""];
      switch-group = ["<Super>i" "<Super>e"];
      switch-group-backward = ["<Shift><Super>i"];
      cycle-windows = [""];
      cycle-windows-backward = [""];
      switch-applications = ["<Super>o" "<Super>w"];
      switch-applications-backward = [""];
      close = ["<Super>d"];
      move-to-center = ["<Super>c"];
      activate-window-menu = ["<Alt>space"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
      move-to-workspace-10 = ["<Super><Shift>0"];
    };
    
    "org/gnome/shell/keybindings" = {
      toggle-application-view = ["<Super>a"];
      toggle-message-tray = ["<Super>t"];
      toggle-quick-settings = ["<Super>s"];
      toggle-overview = ["<Super>p"];
      switch-to-application-1 = [""];
      switch-to-application-2 = [""];
      switch-to-application-3 = [""];
      switch-to-application-4 = [""];
      switch-to-application-5 = [""];
      switch-to-application-6 = [""];
      switch-to-application-7 = [""];
      switch-to-application-8 = [""];
      switch-to-application-9 = [""];
      switch-to-application-10 = [""];
      open-new-window-application-1 = [""];
      open-new-window-application-2 = [""];
      open-new-window-application-3 = [""];
      open-new-window-application-4 = [""];
      open-new-window-application-5 = [""];
      open-new-window-application-6 = [""];
      open-new-window-application-7 = [""];
      open-new-window-application-8 = [""];
      open-new-window-application-9 = [""];
    };
    
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Super>z"];
    };
    
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      clock-show-date = true;
      clock-format = "24h";
      cursor-size = 40;
    };
    
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    
    "org/gnome/shell/extensions/go-to-last-workspace" = {
      shortcut-key = ["<Super>g"];
    };
  };
}