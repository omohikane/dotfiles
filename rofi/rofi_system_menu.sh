#!/bin/bash
if [[ -z $@ ]]; then
    OPTIONS="Power-off\nReboot\nSuspend\nHibernate"
    OPTIONS="Suspend\nLock\nReboot\nShutdown"
    echo -e $OPTIONS
else
    case $option in
    Reboot)
        systemctl reboot ;;
    Shutdown)
        systemctl poweroff ;;
    Suspend)
        systemctl suspend ;;
    Hibernate)
        systemctl hibernate ;;
    Lock)
	lock ;;    
    *)
        ;;
    esac
fi


