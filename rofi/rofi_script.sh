#!/bin/bash

## System Menu
rofi.modi: combi, window, run, ssh, system:rofi_system_menu.sh
rofi.combi-modi: window, run, ssh
rofi.show: combi
rofi.lines: 20
rofi.width: 60
rofi.padding: 10
rofi.font: Ubuntu Mono 20
rofi.color-enabled: true
rofi.fake-transparent: true
rofi.fullscreen: false
rofi.fixed-num-lines :true
rofi.hide-scrollbar: true
rofi.sidebar-mode: true

## Key Binding
rofi.kb-cancel        :Escape,Control+g,Control+bracketleft,Control+c
rofi.kb-mode-next     :Shift+Right,Control+l,Control+Tab
rofi.kb-mode-previous :Shift+Left,Control+h
rofi.kb-row-up        :Control+k
rofi.kb-row-down      :Control+j

## rofi color scheme
#rofi.theme:/hoge/huga/themas/hogehoge.rasi