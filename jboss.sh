#!/bin/bash
# jboss - A simple init script to control JBoss.
# All this script really does is use JBoss' existing tools to start and stop it
# as the 'jboss' user. As a result, success/failure isn't really accurate. 
#
# chkconfig: 345 96 20
# description: Control JBoss AS 7
# processname: jboss

PROG=jboss
JBOSS_BIN=/opt/jboss/bin
JBOSS_USER=jboss
WAIT=10
RETVAL=0

# Source function library.
. /etc/rc.d/init.d/functions


start() {
  echo -n "Starting $PROG "
  # > /dev/null 2>&1 &
  su -l $JBOSS_USER -c "$JBOSS_BIN/standalone.sh"
  RETVAL=$?
  [ $RETVAL = 0 ] && success || failure
  echo
  return $RETVAL
}

stop() {
  echo -n "Stopping $PROG "
  su -l $JBOSS_USER -c "$JBOSS_BIN/jboss-cli.sh --connect command=:shutdown"
  RETVAL=$?
  [ $RETVAL = 0 ] && success || failure
  echo
  return $RETVAL
}

killjava() {
  # This really isn't a friendly way to restart JBoss and doesn't always work.
  echo -n "Killing remaining Java instances "
  killall java
  RETVAL=$?
  [ $RETVAL = 0 ] && success || failure
  start
}

case "$1" in
  start)
    start
  ;;
  stop)
    stop
  ;;
  restart)
    stop
    sleep $WAIT
    start
  ;;
  forcerestart)
    stop
    sleep $WAIT
    killjava
    start
  ;;
  *)
    echo "Usage: $PROG {start|stop|restart|forcerestart}"
    exit 1
esac

exit 0

