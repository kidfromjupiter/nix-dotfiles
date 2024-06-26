{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hyprland-environment.nix
  ];

  home.packages = with pkgs; [ 
    waybar
    swww
  ];
  
  #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    extraConfig = ''
    exec-once=/nix/store/nc3fis9947rpakhni034hm9c4dfjda79-dbus-1.14.8/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP && systemctl --user start hyprland-session.target

    # Monitor
    monitor=DP-1,1920x1080@60,auto,1

    # Fix slow startup
    exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP 

    # Autostart

    exec-once = hyprpaper
    exec-once = hyprctl setcursor Bibata-Modern-Classic 24
    exec-once = dunst
    exec-once = hyprctl hyprpaper wallpaper "DP-1,/home/lasan/.config/wall.jpg"

    source = /home/lasan/.config/hypr/colors
    exec = pkill waybar & sleep 0.5 && waybar
#    exec-once = swww init & sleep 0.5 && exec wallpaper_random
    # exec-once = wallpaper_random

    # Set en layout at startup

    # Input config
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = false
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {

        gaps_in = 5
        gaps_out = 5
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    decoration {

        rounding = 10
        blur = true
        blur_size = 3
        blur_passes = 1
        blur_new_optimizations = true

        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = yes

        bezier = ease,0.4,0.02,0.21,1

        animation = windows, 1, 3.5, ease, slide
        animation = windowsOut, 1, 3.5, ease, slide
        animation = border, 1, 6, default
        animation = fade, 1, 3, ease
        animation = workspaces, 1, 3.5, ease
    }

    dwindle {
        pseudotile = yes
        preserve_split = yes
    }

    master {
        new_is_master = yes
    }

    gestures {
        workspace_swipe = true
    }
    
    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

    windowrule=float,^(pavucontrol)$
    windowrule=float,^(blueman-manager)$
    windowrule=size 934 525,^(mpv)$
    windowrule=float,^(mpv)$
    windowrule=center,^(mpv)$
    #windowrule=pin,^(firefox)$

    windowrulev2=workspace 2,class:^(firefox)$
    windowrulev2=workspace 3,class:^(kitty|code-url-handler)$
    windowrulev2=workspace 1,class:^(org.gnome.Nautilus)$
    #windowrulev2=workspace 2,class:^(firefox)$
    #windowrulev2=workspace 2,class:^(firefox)$
    #windowrulev2=workspace 2,class:^(firefox)$
    $mainMod = SUPER
    bind = $mainMod, G, fullscreen,


    #bind = $mainMod, RETURN, exec, cool-retro-term-zsh
    bind = $mainMod, RETURN, exec, kitty
 #   bind = $mainMod, B, exec, opera --no-sandbox
    bind = $mainMod, B, exec, firefox 
    bind = $mainMod SHIFT, B, exec, firefox --private-window
    bind = $mainMod, Q, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, S, exec, nautilus
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, E, exec, wofi --show drun
    bind = $mainMod, R, exec, rofiWindow
    bind = $mainMod, P, pseudo, # dwindle
#    bind = $mainMod, J, togglesplit, # dwindle

    # Switch Keyboard Layouts
#    bind = $mainMod, SPACE, exec, hyprctl switchxkblayout teclado-gamer-husky-blizzard next

    bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
    bind = $mainMod, P, exec, grim -g "$(slurp)" - | wl-copy
    bind = SHIFT, Print, exec, grim -g "$(slurp)"
    bind = $mainMod SHIFT, P, exec, grim -g "$(slurp)"

    # Functional keybinds
    bind =,XF86AudioMicMute,exec,pamixer --default-source -t
    binde =,XF86MonBrightnessDown,exec,light -U 20
    binde =,XF86MonBrightnessUp,exec,light -A 20
    binde = $mainMod,minus,exec,brightnessctl s 10%-
    binde = $mainMod,equal,exec,brightnessctl s +10%
    bind =,XF86AudioMute,exec,pamixer -t
    binde =,XF86AudioLowerVolume,exec,pamixer -d 10
    binde = $mainMod,bracketright,exec,pamixer -i 10
    binde = $mainMod,bracketleft,exec,pamixer -d 10
#    bind =$mainMod,
    binde =,XF86AudioRaiseVolume,exec,pamixer -i 10
    binde =,XF86AudioPlay,exec,playerctl play-pause
    bind =,XF86AudioPause,exec,playerctl play-pause

    # to switch between windows in a floating workspace
#    bind = SUPER,,cyclenext,
    bind = SUPER,Tab,bringactivetotop,

    # Move focus with mainMod + arrow keys
    bind = $mainMod, j, movefocus, l
    bind = $mainMod, k, movefocus, r
    bind = $mainMod, i, movefocus, u
    bind = $mainMod, m, movefocus, d
    
    #fullscreen
    bind = $mainMod,c,fullscreen,0
    # grouping
    bind = $mainMod, T, togglegroup
    bind = $mainMod SHIFT, J, moveintogroup,l
    bind = $mainMod SHIFT, K, moveintogroup,r
    bind = $mainMod SHIFT, I, moveintogroup,u
    bind = $mainMod SHIFT, L, moveintogroup,d
    bind = $mainMod CTRL, J, changegroupactive,b
    bind = $mainMod CTRL, K, changegroupactive,f
    bind = $mainMod, N, moveoutofgroup
    
    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    #resizing
    binde = $mainMod, H , resizeactive, -30 0
    binde = $mainMod, L, resizeactive, 30 0

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bindm = ALT, mouse:272, resizewindow

    '';
};
}
