#rofiの設定ファイル　いろいろ混ぜてる感じ
#hoge.shにして/bin/hoge.shに実行属性を付けてi3wmで指定して立ち上げるようにする


#######################################################################################################
##rofi_system_menu.sh
#!/bin/bash
# 表示したい項目と実際に実行するコマンドを連想配列として定義する。
declare -A list=(

  ##  LOCK  ##
  ['Lock']='gnome-screensaver-command -l'
  ['Logout']='gnome-session-quit --force'
  ##  POWER  ##
  ['Suspend']='systemctl suspend'
  ['Shutdown']='systemctl poweroff'
  ['Reboot']='systemctl reboot'
)

# $1がnot zeroなら$1に入っているコマンドを実行する。
# $1がzeroなら連想配列のkeyを表示する。

if [[ ${1##* } == 'yes' ]]; then
  eval ${list[${1%% *}]}
elif [[ ${1##* } == 'no' ]]; then
  echo ${!list[@]} | sed 's/ /\n/g'
elif [[ -n $1 ]]; then
  echo "$1 / no"
  echo "$1 / yes"
else
  echo ${!list[@]} | sed 's/ /\n/g'
fi
########################################################################################################

  ##  Lock  ##
  "Lock Screen" "gnome-screensaver-command -l"
  "Logout"      "gnome-session-quit --force"
  ##  Power ##
  "Reboot"      "systemctl reboot"
  "Suspend"     "systemctl suspend"
  "Shutdown"    "systemctl poweroff"

########################################################################################################



#!/bin/bash
# rofi_launch.sh / JennyM 2016 malkalech.com

alpha="cc"   # opacity (00?FF)

options=(
  -modi            "combi,run,ssh,system:rofi_system_menu.sh"
  -combi-modi      "window,drun"
  -show            "combi"
  -font            "Ubuntu 28"
  -width           "80"
  -padding         "30"
  -lines           "10"
  -fixed-num-lines
  -hide-scrollbar
  -sidebar-mode

  ##  key bindings  ##
  ##キャンセルはESC、Emacs,Vim
  ##モード切替はvimライクにCtrl+hlを入れておく
  ##カーソルのアップダウンもjkを割り当て
  -kb-cancel        "Escape,Control+g,Control+bracketleft,Control+c"
  -kb-mode-next     "Shift+Right,Control+l,Control+Tab"
  -kb-mode-previous "Shift+Left,Control+h"
  -kb-row-up        "Control+k"
  -kb-row-down      "Control+j"

  #### color scheme
  -color-enabled   "true"
  ## window         bg                   border               separator
  -color-window    "argb:${alpha}040404, argb:${alpha}040404, argb:${alpha}458588"
  ## text & cursor  bg             fg                   bg (alt)       bg (highlight)       fg (highlight)
  -color-normal    "argb:00000000, argb:${alpha}458588, argb:00000000, argb:${alpha}076678, argb:${alpha}83a598"
  -color-active    "argb:00000000, argb:${alpha}689d6a, argb:00000000, argb:${alpha}427b58, argb:${alpha}8ec07c"
  -color-urgent    "argb:00000000, argb:${alpha}b16286, argb:00000000, argb:${alpha}8f3f71, argb:${alpha}d3869b"
)

rofi "$@" "${options[@]}"


##lain の人!! Rofi
rofi.modi: combi,window,run,ssh
rofi.combi-modi: window,run,ssh
rofi.show: combi
rofi.lines: 24
rofi.width: 60
rofi.padding: 10
rofi.font: Ubuntu Mono 12
rofi.color-enabled: true
rofi.fake-transparent: true
rofi.fullscreen: false



