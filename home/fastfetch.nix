{ ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        padding = {
          top = 2;
          right = 4;
        };
        color = {
          "1" = "blue";
          "2" = "cyan";
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = "blue";
          title = "cyan";
        };
        constants = [
          "──────────────────────────────"
        ];
      };

      modules = [
        {
          type = "title";
        }
        {
          type = "custom";
          format = "──────────────────────────────";
        }
        {
          type = "custom";
          format = "{#1}╭─ {#7}system ──────────────────────────╮";
        }
        {
          type = "os";
          key = "{#1} os  ";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "{#1} krn ";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = "{#1} pkg ";
          keyColor = "blue";
        }
        {
          type = "shell";
          key = "{#1} sh  ";
          keyColor = "blue";
        }
        {
          type = "uptime";
          key = "{#1} up  ";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "{#1}╰──────────────────────────────────────╯";
        }
        "break"
        {
          type = "custom";
          format = "{#1}╭─ {#7}desktop ─────────────────────────╮";
        }
        {
          type = "wm";
          key = "{#1}󰧨 wm  ";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "{#1} term";
          keyColor = "blue";
        }
        {
          type = "display";
          key = "{#1}󰍹 disp";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "{#1}╰──────────────────────────────────────╯";
        }
        "break"
        {
          type = "custom";
          format = "{#1}╭─ {#7}hardware ────────────────────────╮";
        }
        {
          type = "cpu";
          key = "{#1} cpu ";
          keyColor = "blue";
          showPeCoreCount = true;
        }
        {
          type = "gpu";
          key = "{#1}󰢮 gpu ";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "{#1} mem ";
          keyColor = "blue";
        }
        {
          type = "disk";
          key = "{#1}󰋊 dsk ";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "{#1}╰──────────────────────────────────────╯";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
