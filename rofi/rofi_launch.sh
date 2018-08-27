#!/bin/bash
SMENU="system:$HOME/.config/rofi/rofi_system_menu.sh"
exec rofi -modi combi,run,ssh,"$SMENU" -combi-modi window,drun,run,ssh -show combi -location 0 -sidebar-mode
