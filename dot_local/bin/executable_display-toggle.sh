#!/bin/bash
case "$1" in
    triple)
        swaymsg output DP-2 enable
        swaymsg output HDMI-A-2 enable
        ;;
    single)
        swaymsg output DP-2 disable
        swaymsg output HDMI-A-2 disable
        ;;
    dual)
        swaymsg output DP-2 enable
        swaymsg output HDMI-A-2 disable
        ;;
esac
