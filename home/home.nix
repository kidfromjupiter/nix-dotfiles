{ hyprland, pkgs, ...}: {

  imports = [
    hyprland.homeManagerModules.default
    #./environment
    ./programs
    ./scripts
    ./themes
    
  ];

  home = {
    username = "lasan";
    homeDirectory = "/home/lasan";
  };

  home.packages = (with pkgs; [
    
    #User Apps
    celluloid
    kitty
    discord
    bibata-cursors
    vscode
    lollypop
    betterdiscord-installer
    firefox
    unityhub

    #utils
    ranger
    wlr-randr
    git
    gnumake
    catimg
    curl
    appimage-run
    xflux
    dunst
    pavucontrol
    sqlite

    #misc 
    cava
    neovim
    nano
    wofi
    nitch
    wget
    grim
    slurp
    wl-clipboard
    pamixer
    mpc-cli
    tty-clock
    btop
    gedit
    tokyo-night-gtk
    ntfs3g


  ]) ++ (with pkgs.gnome; [ 
    nautilus
    zenity
    gnome-tweaks
    eog
  ]);

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
