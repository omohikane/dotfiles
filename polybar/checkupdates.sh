#!/bin/sh

if ! updates=$(apt list --upgradable 2> /dev/null | wc -l) ; then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo "😢 $(($updates - 1))"
else
    echo "☺😆 $updates"
fi
