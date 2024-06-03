{ config, lib, pkgs, ... }:{
  home.file = {
    "/home/lasan/.config/hypr/hyprpaper.conf" = {
      text = ''
        preload = /home/lasan/.config/wall.jpg
        wallpaper = ,/home/lasan/.config/wall.jpg
      ''
    }
  };

  };
