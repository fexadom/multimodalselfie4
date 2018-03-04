#!/bin/sh

# Quick start-stop-daemon example, derived from Debian /etc/init.d/ssh
set -e

# Must be a valid filename
DATE=$(date +"%Y%m%d%H%M")
NAME=m210
PIDFILE=/opt/recording/$NAME.pid
#This is the command to be run, give the full pathname
DAEMON="/usr/local/bin/m210 stream_daemon"
DAEMON_OPTS="--output-file=/opt/recording/data/notas$DATE.txt"

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
  start)
        echo -n "Starting daemon: "$NAME
	start-stop-daemon --start --quiet --pidfile $PIDFILE -c pi --exec $DAEMON -- $DAEMON_OPTS
        echo ". "
	;;
  stop)
        echo -n "Stopping daemon: "$NAME
	start-stop-daemon -s USR1 --stop --quiet --oknodo --pidfile $PIDFILE
        echo ". "
	;;
  restart)
        echo -n "Restarting daemon: "$NAME
	start-stop-daemon -s USR1 --stop --quiet --oknodo --retry 30 --pidfile $PIDFILE
	start-stop-daemon --start --quiet --pidfile $PIDFILE -c pi --exec $DAEMON -- $DAEMON_OPTS
	echo ". "
	;;

  *)
	echo "Usage: "$1" {start|stop|restart}"
	exit 1
esac

exit 0
