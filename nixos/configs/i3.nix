{pkgs, lib, ... }:
let
  modify = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = rec {
        # modifier = "Mod4";
        bars = [ ];
        assigns = {};
        modifier = "Mod3"; # Empty
        keybindings = lib.mkOptionDefault {
          "${modify}+Shift+Return" = "exec --no-startup-id samedir";
          "${modify}+Shift+space" = "floating toggle";
          "${modify}+space"  =  "focus mode_toggle";
          "${modify}+Shift+c"  =  "exec --no-startup-id i3 restart";
          "${modify}+Escape"  =  "workspace prev";  
          "${modify}+r"  =  "mode \"resize\"";        
          # "${modify}+o"  =  "kill `xdotool getwindowfocus getwindowpid`";
          "${modify}+t"  =  "split toggle";
          "${modify}+Shift+t"  =  "gaps inner current set 15; gaps outer current set 15";
          "${modify}+Shift+y"  =  "exec --no-startup-id i3resize left";
          "${modify}+j"  =  "exec --no-startup-id spotify";
          "${modify}+k"  =  "exec --no-startup-id wps";
          "${modify}+u"  =  "exec --no-startup-id brave";
          "${modify}+Shift+u"  =  "exec --no-startup-id i2resize down";
          "${modify}+Shift+i"  =  "exec --no-startup-id i3resize up";
          "${modify}+Shift+o"  =  "exec --no-startup-id i3resize right";
          "${modify}+a"  =  "exec --no-startup-id ddspawn dropdowncalc -f mono:pixelsize=24";      
          "${modify}+s"  =  "gaps inner current plus 5";
          "${modify}+Shift+d"  =  "gaps inner current set 0; gaps outer current set 0";
          "${modify}+f"  =  "fullscreen toggle";
          "${modify}+Shift+h"  =  "move left 30";
          "${modify}+Ctrl+h"  =  "move workspace to output left";
          "${modify}+Shift+j"  =  "move down 30";
          "${modify}+Ctrl+j"  =  "move workspace to output down";
          "${modify}+Shift+k"  =  "move up 30";
          "${modify}+Ctrl+k"  =  "move workspace to output up";
          "${modify}+Shift+l"  =  "move right 30";
          "${modify}+Ctrl+l"  =  "move workspace to output right";
          "${modify}+z"  =  "gaps outer current plus 5";
          "${modify}+Shift+z"  =  "gaps outer current minus 5";
          "${modify}+c"  =  "exec --no-startup-id cabl";
          "${modify}+b"  =  "bar mode toggle";
          "${modify}+Shift+b"  =  "floating toggle; sticky toggle; exec --no-startup-id hover left";      
          "${modify}+Shift+n"  =  "floating toggle; sticky toggle; exec --no-startup-id hover right";       # #---Workspace Bindings---# #";
          "${modify}+Home"  =  "workspace $ws1";
          "${modify}+Shift+Home"  =  "move container to workspace $ws0";
          "${modify}+End"  =  "workspace $ws10";
          "${modify}+Shift+End"  =  "move container to workspace $ws10";
          "${modify}+Prior"  =  "workspace prev";
          "${modify}+Shift+Prior"  =  "move container to workspace prev";
          "${modify}+Next"  =  "workspace next";
          "${modify}+Shift+Next"  =  "move container to workspace next";
          "${modify}+Tab"  =  "workspace back_and_forth";
          "${modify}+XF86Back"  =  "workspace prev";
          "${modify}+Shift+XF86Back"  =  "move container to workspace prev";
          "${modify}+XF86Forward"  =  "workspace next";
          "${modify}+Shift+XF86Forward"  =  "move container to workspace next";
          "${modify}+apostrophe"  =  "split horizontal ;; exec $term";
          "${modify}+slash"  =  "split vertical ;; exec $term";
          "${modify}+Shift+slash"  =  "kill";
          "${modify}+backslash"  =  "workspace back_and_forth";
          # #---Function Buttons---# #";
          "${modify}+F2"  =  "restart";
          # #---Arrow Keys---# #";
          "${modify}+Left"  =  "focus left";
          "${modify}+Ctrl+Left"  =  "move workspace to output left";
          "${modify}+Down"  =  "focus";
          "${modify}+Ctrl+Down"  =  "move workspace to output down";
          "${modify}+Up"  =  "focus up";
          "${modify}+Ctrl+Up"  =  "move workspace to output up";
          "${modify}+Right"  =  "focus right";
          "${modify}+Ctrl+Right"  =  "move workspace to output right";
          "${modify}+Shift+Left"  =  "move left";
          "${modify}+Shift+Down"  =  "move down";
          "${modify}+Shift+Up"  =  "move up";
          "${modify}+Shift+Right"  =  "move right";
        };
      };
    extraConfig = ''
        #set ${modify} Mod4
        floating_modifier ${modify}
        bindsym ${modify}+o   [con_id="__focused__" instance="^(?!dropdown_).*$"] kill
        exec_always --no-startup-id autotiling
        exec_always --no-startup-id dunst
        exec_always --no-startup-id sh ~/.config/polybar/launch.sh
        # exec_always --no-startup-id ~/.scripts/monitorconfig.sh
        exec_always --no-startup-id ~/.local/bin/remaps
        exec --no-startup-id  picom -b
        exec --no-startup-id sh $HOME/.scripts/background/cron.sh $HOME/Pictures/Sci-Fi
        #exec_always --no-startup-id  kill `ps -aux | grep ~/.scripts/background/background.sh |grep "/bin" |awk '{ print $2 }'`
        # Basic color configuration using the Base16 variables for windows and borders.
        # Property Name         Border  BG      Text    Indicator Child Border
        client.focused          #8a2be2 #285577 #ffffff #770000 #8a2be2
        client.focused_inactive #8a2be2 #5f676a #ffffff #484e50 #8a2be2
        client.unfocused        #5e188f #222222 #888888 #292d2e #5e188f
        client.urgent           #2f343a #900000 #ffffff #900000 #900000
        client.placeholder      #53188f #0c0c0c #ffffff #000000 %53188f
        client.background       #2B2C2B
        #smart_gaps on
        #smart_borders on
        #border_radius 15        # #---Basic Definitions---# #
        for_window [class="^.*"] border pixel 0
        gaps inner 3
        gaps outer 3
        set $term --no-startup-id
        # #---Dropdown Windows---# #
        font xft:MeslosLGS NF 12
        # General dropdown window traits. The order can matter.
        for_window [instance="dropdown_*"] floating enable
        for_window [instance="dropdown_*"] move scratchpad
        for_window [instance="dropdown_*"] sticky enable
        for_window [instance="dropdown_*"] scratchpad show
        for_window [instance="dropdown_tmuxdd"] resize set 625 450
        for_window [instance="dropdown_dropdowncalc"] resize set 800 300
        for_window [instance="dropdown_tmuxdd"] border pixel 3
        for_window [instance="dropdown_dropdowncalc"] border pixel 2
        for_window [instance="dropdown_*"] move position center
        #bar {
        # font pango:mono 10
        # status_command i3blocks
        # position top
        # mode dock
        # modifier None
        #}
        smart_borders on
        # #---Basic Bindings---# #
        #STOP/HIDE EVERYTHING:
        bindsym ${modify}+Shift+Delete exec --no-startup-id lmc truemute ; exec --no-startup-id lmc pause ; exec --no-startup-id pauseallmpv; workspace 0; exec $term -e htop ; exec $term -e $FILE
        #bindsym ${modify}+Return exec ---no-startup-id kitty
        # #---Letter Key Bindings---# #        # resize window (you can also use the mouse for that)
        # mode "resize" {
        #         # These bindings trigger as soon as you enter the resize mode                # Pressing left will shrink the window’s width.
        #         # Pressing right will grow the window’s width.
        #         # Pressing up will shrink the window’s height.
        #         # Pressing down will grow the window’s height.
        #         bindsym h resize shrink width 5 px or 5 ppt
        #         bindsym j resize grow height 5 px or 5 ppt
        #         bindsym k resize shrink height 5 px or 5 ppt
        #         bindsym l resize grow width 5 px or 5 ppt                # same bindings, but for the arrow keys
        #         bindsym Left resize shrink width 5 px or 5 ppt
        #         bindsym Down resize grow height 5 px or 5 ppt
        #         bindsym Up resize shrink height 5 px or 5 ppt
        #         bindsym Right resize grow width 5 px or 5 ppt                # back to normal: Enter or Escape
        #         bindsym Return mode "default"
        #         bindsym Escape mode "default"
        # }
        set $freeze Distraction-free mode (super+shift+f to reactivate bindings)
        mode "$freeze" { bindsym ${modify}+Shift+f mode "default"
        }        
        set $monitor1 "DP-2"
        set $monitor2 "DP-0"        
        set $ws1 "1: Main"
        set $ws2 "2: Steam"
        set $ws3 "3: Games"
        set $ws4 "4: Streaming"
        set $ws5 "5: Open"
        set $ws6 "6: Audio"
        set $ws7 "7: Discord etc."
        set $ws8 "8: Videos"
        set $ws9 "9: Teams"
        set $ws10 "10"
        workspace $ws1 output $monitor1
        workspace $ws2 output $monitor1
        workspace $ws3 output $monitor1
        workspace $ws4 output $monitor1
        workspace $ws5 output $monitor1
        workspace $ws6 output $monitor2
        workspace $ws7 output $monitor2
        workspace $ws8 output $monitor2
        workspace $ws9 output $monitor2
        workspace $ws10 output $monitor2        #Autostart apps on spec workspaces
        exec --no-startup-id brave
        #exec --no-startup-id sleep 6 && i3-msg 'workspace $ws6; exec $TERMINAL -e ncmpcpp'
        exec --no-startup-id spotify
        exec --no-startup-id discord
        # switch to workspace
        bindsym ${modify}+1    workspace $ws1
        bindsym ${modify}+2    workspace $ws2
        bindsym ${modify}+3    workspace $ws3
        bindsym ${modify}+4    workspace $ws4
        bindsym ${modify}+5    workspace $ws5
        bindsym ${modify}+6    workspace $ws6
        bindsym ${modify}+7    workspace $ws7
        bindsym ${modify}+8    workspace $ws8
        bindsym ${modify}+9    workspace $ws9
        bindsym ${modify}+0    workspace $ws10       
        bindsym ${modify}+Shift+1  move container to workspace $ws1
        bindsym ${modify}+Shift+2  move container to workspace $ws2
        bindsym ${modify}+Shift+3  move container to workspace $ws3
        bindsym ${modify}+Shift+4  move container to workspace $ws4
        bindsym ${modify}+Shift+5  move container to workspace $ws5
        bindsym ${modify}+Shift+6  move container to workspace $ws6
        bindsym ${modify}+Shift+7  move container to workspace $ws7
        bindsym ${modify}+Shift+8  move container to workspace $ws8
        bindsym ${modify}+Shift+9  move container to workspace $ws9
        bindsym ${modify}+Shift+0  move container to workspace $ws10        
        for_window [class="Pinentry"] sticky enable
        for_window [class="sent"] border pixel 0px
        for_window [title="GIMP Startup"] move workspace $ws5
        for_window [class="Gimp"] move workspace $ws5
        for_window [window_role="GtkFileChooserDialog"] resize set 800 600
        for_window [window_role="GtkFileChooserDialog"] move position center
        for_window [title="Default - Wine desktop"] floating enable        ##Steam
        for_window [class="^Steam$" title="Friends"] floating enable
        for_window [class="^Steam$" title="Steam - News"] floating enable
        for_window [class="^Steam$" title=".* - Chat"] floating enable
        for_window [class="^Steam$" title="^Settings$"] floating enable
        for_window [class="^Steam$" title=".* - event started"] floating enable
        for_window [class="^Steam$" title=".* CD key"] floating enable
        for_window [class="^Steam$" title="^Steam - Self Updater$"] floating enable
        for_window [class="^Steam$" title="^Screenshot Uploader$"] floating enable
        for_window [class="^Steam$" title="^Steam Guard - Computer Authorization Required$"] floating enable
        for_window [class="Sxiv"] floating enable
        for_window [class="Sxiv"] resize set 740 1060
        for_window [class="Pavucontrol"] floating enable
        for_window [class="Pavucontrol"] resize set 1000 500
        for_window [class="Gimp"] floating enable
        for_window [class="Gimp" title="^GNU*"] resize set 2560 1050
        #for_window [class="Gimp" title="^Change Foreground*"] resize set 400 400
        #New Instances in specific window
        #One
        assign [class="^Brave*"] workspace $ws1        #Two
        for_window [class="^Steam*"] move to workspace $ws2        #Three
        #for_window [class="^steam_app*"] move to workspace $ws3
        for_window [class="^steam_app*"] floating enable
        #Four
        assign [class="^qtwebflix*"] workspace $ws4
        assign [class="^electronplayer*"] workspace $ws4        #Five
        assign [class="Komikku"] workspace $ws5
        for_window [class="Komikku"] floating enable
        for_window [class="Komikku"] resize set 700 1050
        #Six
        assign [class="^Pulse*"] workspace $ws6
        for_window [class="^Spotify*"] move to workspace $ws6 
          #assign [class="*" title="*ncmpcpp*"] workspace 6  #### This is broken
        #Seven
        for_window [class="^.*iscord*"] move to workspace $ws7
        #Eight
        for_window [class="mpv"] move to workspace $ws8
        #Nine        #Ten
        # Bindings to make the webcam float and stick.
        for_window [title="mpvfloat"] floating enable
        for_window [title="mpvfloat"] sticky enable
        for_window [title="mpvfloat"] border pixel 0
        no_focus [title="mpvfloat"]
    '';
    };

}
