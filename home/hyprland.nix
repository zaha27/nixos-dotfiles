{ pkgs, ... }:

let
  fullscreenToNewWs = pkgs.writeShellScript "hypr-fullscreen-to-new-ws" ''
    sock="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
    ${pkgs.socat}/bin/socat -U - UNIX-CONNECT:"$sock" | while read -r line; do
      case "$line" in
        fullscreen\>\>1)
          ${pkgs.hyprland}/bin/hyprctl dispatch movetoworkspace emptynm
          ;;
      esac
    done
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      monitor = [
        "DP-6, 3840x2160@240, 0x0, 1"
        "DP-5, 2560x1440@120, -1440x0, 1, transform, 3"
        ", preferred, auto, 1"
      ];

      workspace = [
        "1, monitor:DP-6, default:true"
        "2, monitor:DP-6"
        "4, monitor:DP-6"
        "5, monitor:DP-6"
        "7, monitor:DP-5, default:true"
        "8, monitor:DP-5"
        "9, monitor:DP-5"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
      ];

      exec-once = [
        "waybar"
        "hyprpaper"
        "swaync"
        "${fullscreenToNewWs}"
      ];

      windowrulev2 = [
        "float, class:^(btop-float)$"
        "size 1200 800, class:^(btop-float)$"
        "center, class:^(btop-float)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(pavucontrol)$"

        "immediate, class:^(steam_app_).*$"
        "immediate, class:^(cs2)$"
        "immediate, class:^(gamescope)$"
        "fullscreen, class:^(gamescope)$"
        "workspace 5 silent, class:^(steam)$, title:^(?!Steam).*$"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgba(bac2deff)";
        "col.inactive_border" = "rgba(313244ff)";
        layout = "dwindle";
        allow_tearing = true;
        resize_on_border = true;
        extend_border_grab_area = 15;
        hover_icon_on_border = true;
      };

      misc = {
        vrr = 2;
        vfr = true;
      };

      cursor = {
        no_hardware_cursors = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 6;
          passes = 2;
        };
        shadow.enabled = false;
      };

      animations = {
        enabled = true;
        bezier = "smoothOut, 0.25, 0.1, 0.25, 1";
        animation = [
          "windows, 1, 1, smoothOut"
          "windowsOut, 1, 1, smoothOut"
          "border, 1, 2, smoothOut"
          "fade, 1, 1, smoothOut"
          "workspaces, 1, 1, smoothOut"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 0;
        touchpad.natural_scroll = false;
        sensitivity = 0;
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, T, exec, alacritty"
        "$mod, W, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, dolphin"
        "$mod, V, togglefloating,"
        "$mod, SPACE, exec, wofi --show drun"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        "$mod, F, fullscreen,"

        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"

        "$mod SHIFT, left,  movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up,    movewindow, u"
        "$mod SHIFT, down,  movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up,   workspace, e-1"

        "$mod SHIFT, P, exec, grim -g \"$(slurp)\" - | wl-copy"

        "$mod, Escape, exec, alacritty --class btop-float -e btop"
        "$mod, N, exec, swaync-client -t -sw"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute,        exec, wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${../assets/painting.jpg}" ];
      wallpaper = [ ",${../assets/painting.jpg}" ];
    };
  };
}
