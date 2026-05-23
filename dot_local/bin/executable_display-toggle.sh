#!/bin/bash
case "$1" in
    triple)
        swaymsg output DP-3 enable
        swaymsg output HDMI-A-1 enable
        ;;
    single)
        swaymsg output DP-3 disable
        swaymsg output HDMI-A-1 disable
        ;;
    dual)
        swaymsg output DP-3 enable
        swaymsg output HDMI-A-1 disable
        ;;
esac
