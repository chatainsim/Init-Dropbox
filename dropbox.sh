#!/bin/sh
PID=`ps -C dropbox -o pid=`
DROP="/home/$USER/.dropbox/dropbox.py"
start() {
	if [ "x$PID" = "x" ];
	then
		echo "Starting Dropbox ..."
		$DROP start
		RESULT=$?
		if [ "$RESULT" = "0" ];
		then
			echo "Starting Dropbox ... [OK]"
		else
			echo "Starting Dropbox ... [ERROR]"
		fi
	else
		echo "[OK] - Dropbox already started."
	fi
}
stop() {
	if [ "x$PID" = "x" ];
	then
		echo "[OK] - Dropbox is stopped."
	else
		echo "Stopping Dropbox ..."
		$DROP stop
		RESULT=$?
		if [ "$RESULT" = "0" ];
		then
			echo "Stopping Dropbox ... [OK]"
		else
			echo "Stopping Dropbox ... [ERROR]"
		fi
	fi
}
restart() {
	if [ "x$PID" = "x" ];
	then
		echo "[OK] - Dropbox is already stopped."
		start
	else
		stop
		start
	fi
}
status() {
	STATUS=`$DROP status`
	echo "Dropbox status is : $STATUS"
}
usage() {
	echo ""
	echo "Usage : dropbox.sh <start|stop|restart|status>"
	echo ""
	echo "start		Start Dropbox"
	echo "stop		Stop Dropbox"
	echo "restart		Restart Dropbox"
	echo "status		Show Dropbox status"
	echo ""
}
if [ "x$1" = "x" ];
  then
	usage
	exit 1
  else
	case $1 in
		status)
			status
		;;
		start)
			start
		;;
		stop)
			stop
		;;
		*)
			usage
			exit 1
		;;
	esac
fi
