{ pkgs, lib, ... }:

let
  # Modules shared by both bars — only the output and workspace list differ.
  commonBar = {
    layer = "top";
    position = "top";
    height = 34;
    spacing = 6;

    modules-left = [ "hyprland/workspaces" "hyprland/window" ];
    modules-center = [ "clock" ];
    modules-right = [
      "custom/taskmanager"
      "pulseaudio"
      "bluetooth"
      "network"
      "battery"
      "tray"
      "custom/notification"
    ];

    "hyprland/window" = {
      format = "{title}";
      max-length = 60;
    };

    clock = {
      format = "{:%H:%M  %a %d %b}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };

    network = {
      format-wifi = "  {signalStrength}%";
      format-ethernet = "󰈀";
      format-disconnected = "󰤮";
      tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ifname}: {ipaddr}";
      tooltip-format-ethernet = "{ifname}: {ipaddr}";
      tooltip-format-disconnected = "Disconnected";
      on-click = "alacritty -e nmtui";
    };

    bluetooth = {
      format = "󰂯";
      format-disabled = "󰂲";
      format-connected = "󰂱 {num_connections}";
      tooltip-format = "{controller_alias}\t{controller_address}";
      tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
      tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
      on-click = "blueman-manager";
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "󰝟";
      format-icons = {
        default = [ "󰕿" "󰖀" "󰕾" ];
        headphone = "󰋋";
        headset = "󰋎";
      };
      scroll-step = 5;
      on-click = "pavucontrol";
    };

    battery = {
      format = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
      states = { warning = 30; critical = 15; };
    };

    tray = {
      icon-size = 18;
      spacing = 8;
    };

    "custom/taskmanager" = {
      format = "󰈸";
      tooltip = true;
      tooltip-format = "Task manager (btop)";
      on-click = "hyprctl dispatch exec '[float; size 1200 800; center] alacritty --class btop-float -e btop'";
    };

    "custom/notification" = {
      tooltip = false;
      format = "{icon} {}";
      format-icons = {
        notification = "󱅫";
        none = "󰂚";
        dnd-notification = "󰂛";
        dnd-none = "󰂛";
        inhibited-notification = "󰂛";
        inhibited-none = "󰂛";
        dnd-inhibited-notification = "󰂛";
        dnd-inhibited-none = "󰂛";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };

  # One bar per monitor, each showing only its own workspaces.
  #
  # all-outputs = false still shows *any* workspace that happens to live on the
  # output, including ones created dynamically (e.g. the fullscreen script's
  # `movetoworkspace emptynm`). ignore-workspaces hides everything outside the
  # list below, so the bar never grows an unexpected number.
  barFor = monitor: workspaces:
    let
      names = map toString workspaces;
    in
    commonBar // {
      output = [ monitor ];
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        all-outputs = false;
        persistent-workspaces."${monitor}" = workspaces;
        format-icons = lib.listToAttrs
          (map (w: lib.nameValuePair w w) names);
        ignore-workspaces = [
          "^(?!(${lib.concatStringsSep "|" names})$).*$"
        ];
      };
    };
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = {
      mainBar = barFor "DP-6" [ 1 2 3 4 5 ];
      sideBar = barFor "DP-5" [ 7 8 9 ];
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #1e1e2e;
        color: #cdd6f4;
        border-bottom: 1px solid #313244;
      }

      #workspaces button {
        padding: 0 10px;
        color: #6c7086;
        background: transparent;
        border-radius: 0;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        background: transparent;
        color: #cdd6f4;
        border-bottom: 2px solid #bac2de;
      }

      #workspaces button:hover {
        background: #313244;
        color: #cdd6f4;
      }

      #clock,
      #network,
      #pulseaudio,
      #bluetooth,
      #battery,
      #tray,
      #window,
      #custom-taskmanager,
      #custom-notification {
        padding: 0 10px;
        margin: 0;
        border-radius: 0;
        background: transparent;
        color: #bac2de;
      }

      #clock            { color: #cdd6f4; }
      #pulseaudio       { color: #a6adc8; }
      #network          { color: #a6adc8; }
      #bluetooth        { color: #a6adc8; }
      #battery          { color: #a6adc8; }
      #custom-taskmanager { color: #a6adc8; }
      #custom-notification { color: #a6adc8; }

      #pulseaudio.muted,
      #bluetooth.disabled,
      #network.disconnected { color: #585b70; }

      #battery.warning  { color: #f9e2af; }
      #battery.critical {
        color: #f38ba8;
        animation: blink 1s infinite alternate;
      }

      #custom-notification.notification,
      #custom-notification.dnd-notification { color: #f5c2e7; }

      #tray > .passive       { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; }

      @keyframes blink {
        to { color: #1e1e2e; background: #f38ba8; }
      }
    '';
  };
}
