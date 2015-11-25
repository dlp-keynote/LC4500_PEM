#!/bin/sh 
# AKunzman:  09/21/2015
# Startup script for LC4500 BBB software to be run after capemgr.sh

### BEGIN INIT INFO
# Provides:          lc4500_startup.sh
# Required-Start:    $local_fs cron
# Required-Stop:     $local_fs
# Default-Start:     1 2 3 4 5
# Default-Stop:      0 6
# Short-Description: Start LC4500 application at boot time
# Description:       Enable services for interfacing the LC4500 driver board from BBB.
### END INIT INFO

set -e

PATH=/sbin:/bin:/usr/sbin:/usr/bin
test -x /usr/bin/lc4500_main || exit 0

. /lib/lsb/init-functions

case "$1" in
start|reload|force-reload|restart)

	if test -f /usr/bin/lc4500_main; then
		echo "LC4500-PEM application found and launching ..... "
#                nice --adjustment=-10 /usr/bin/lc4500_main &
                 start-stop-daemon -P other:10 --start -m --pidfile /var/run/lc4500.pid --name lc4500 --exec /usr/bin/lc4500_main -b
		
	fi 

        ;;
stop)
       echo "Stopping LC4500-PEM service..."
       set +e
#      start-stop-daemon  --stop -s 15 --pidfile /var/run/lc4500.pid --name lc4500 --exec /usr/bin/lc4500_main
       kill -15 `cat /var/run/lc4500.pid`
       set -e

        exit 0
        ;;
*)
        echo "Usage: /etc/init.d/lc4500_startup.sh {start|stop|reload|restart|force-reload}"
        exit 1
        ;;
esac

exit 0
	echo "LC4500 Startup script completed."

