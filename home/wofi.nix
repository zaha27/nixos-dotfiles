{ ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Run";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 32;
      gtk_dark = true;
    };

    style = ''
      window {
        background-color: rgba(30, 30, 46, 0.95);
        border: 2px solid #89b4fa;
        border-radius: 12px;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 14px;
      }

      #input {
        margin: 8px;
        padding: 8px;
        background-color: #313244;
        color: #cdd6f4;
        border: none;
        border-radius: 8px;
      }

      #inner-box, #outer-box {
        background-color: transparent;
      }

      #scroll {
        margin: 4px;
      }

      #entry {
        padding: 6px 10px;
        color: #cdd6f4;
        border-radius: 8px;
      }

      #entry:selected {
        background-color: #89b4fa;
        color: #1e1e2e;
      }

      #text {
        margin-left: 8px;
      }
    '';
  };
}
