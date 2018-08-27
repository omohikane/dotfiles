#!/bin/bash
declare -A list=(
  ##  LOCK  ##
  ['Lock']='gnome-screensaver-command -l'
  ['Logout']='gnome-session-quit --force'
  ##  POWER  ##
  ['Suspend']='systemctl suspend'
  ['Shutdown']='systemctl poweroff'
  ['Reboot']='systemctl reboot'
)

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