{ ... }:

{
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-width = 500;
      notification-window-width = 420;
      timeout = 6;
      timeout-low = 4;
      timeout-critical = 0;
      fit-to-screen = false;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
      }

      .control-center {
        background: #1e1e2e;
        color: #cdd6f4;
        border: 1px solid #313244;
        border-radius: 0;
        margin: 0;
        padding: 8px;
      }

      .notification-row {
        background: transparent;
        padding: 4px;
      }

      .notification {
        background: #313244;
        color: #cdd6f4;
        border-radius: 0;
        margin: 4px;
        padding: 8px;
        border: 1px solid #45475a;
      }

      .notification-content {
        padding: 6px;
      }

      .close-button {
        background: #f38ba8;
        color: #1e1e2e;
        border-radius: 50%;
        padding: 2px;
        margin: 4px;
      }

      .close-button:hover {
        background: #eba0ac;
      }

      .notification-action {
        background: #45475a;
        color: #cdd6f4;
        border-radius: 0;
        margin: 2px;
      }

      .notification-action:hover {
        background: #585b70;
      }

      .widget-title {
        color: #cdd6f4;
        font-size: 14px;
        margin: 6px;
      }

      .widget-title > button {
        background: #45475a;
        color: #cdd6f4;
        border-radius: 0;
        padding: 4px 8px;
      }

      .widget-dnd {
        color: #cdd6f4;
        margin: 6px;
      }

      .widget-dnd > switch {
        background: #45475a;
        border-radius: 12px;
      }

      .widget-dnd > switch:checked {
        background: #bac2de;
      }

      .widget-mpris {
        color: #cdd6f4;
        background: #313244;
        border-radius: 0;
        margin: 6px;
        padding: 6px;
      }
    '';
  };
}
