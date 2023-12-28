{config, pkgs, ...}:
let 
  lockAction = "sleep 0.5;${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2 -f";
in
{
  programs.wlogout = {
    enable = true;
    layout = [
     {    label = "lock";    action = lockAction;    text = "Lock";    keybind = "l";  }
     {    label = "hibernate";    action = "${lockAction} ; systemctl hibernate";    text = "Hibernate";    keybind = "h";  }
     {    label = "logout";    action = "hyprctl dispatch exit";    text = "Logout";    keybind = "x";  }
     {    label = "shutdown";    action = "systemctl poweroff";    text = "Shutdown";    keybind = "s";  }
     {    label = "suspend";    action = "${lockAction} ; systemctl suspend";    text = "Suspend";    keybind = "u";  }
     {    label = "reboot";    action = "systemctl reboot";    text = "Reboot";    keybind = "r";  }
    ];
    style = ''
* {
  background-image: none;
}
window {
    font-family: Fira Code Regular Nerd Font Complete Mono, monospace;
    font-size: 12pt;
color: #cad3f5; 
    background-color: rgba(30, 32, 48, 0);
}
/* window { */
/*   background-color: rgba(12, 12, 12, 0.6); */
/* } */
button {
  margin: 10px;
  color: #ffffff;
  background-color: rgba(75, 0, 130, 0.75);
  border-style: solid;
  border-width: 1px;
  border-radius: 25px;
  background-repeat: no-repeat;
  background-position: center;
  background-size: 20%;
}

button:focus,
button:active,
button:hover {
  background-color: #ab47bc;
  outline-style: none;
}

#lock {
  background-image: image(
    url("${pkgs.wlogout}/share/wlogout/icons/lock.png")
  );
}

#logout {
  background-image: image(
    url("${pkgs.wlogout}/share/wlogout/icons/logout.png")
  );
}

#suspend {
  background-image: image(
    url("${pkgs.wlogout}/share/wlogout/icons/suspend.png")
  );
}

#hibernate {
  background-image: image(
    url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png")
  );
}

#shutdown {
  background-image: image(
    url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png")
  );
}

#reboot {
  background-image: image(
    url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")
  );
}
'';
  };
}
