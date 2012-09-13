#!/bin/bash
# puppet-dashboard-workers
# Script to control the Puppet Dashboard worker processes using delayed_job
#
# chkconfig: 2345 99 5
# description: Controls Dashboard workers using Puppet Labs' delayed_job script.
# processname: puppet-dashboard-workers

PROG=puppet-dashboard-workers
DASHBOARD_ROOT=/usr/share/puppet-dashboard
RAILS_ENV=production
CPU_CORES=2
RETVAL=0

# Source function library
. /etc/rc.d/init.d/functions


start() {
  echo -n "Starting $PROG "
  env RAILS_ENV=$RAILS_ENV $DASHBOARD_ROOT/script/delayed_job -p dashboard -n $CPU_CORES -m start > /dev/null 2>&1
  RETVAL=$?
  [ $RETVAL = 0 ] && success || failure
  echo
  return $RETVAL
}

stop() {
  echo -n "Stopping $PROG "
  env RAILS_ENV=$RAILS_ENV ${DASHBOARD_ROOT}/script/delayed_job -p dashboard -n $CPU_CORES -m stop > /dev/null 2>&1
  RETVAL=$?
  [ $RETVAL = 0 ] && success || failure
  echo
  return $RETVAL
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
    start
  ;;
  *)
    echo "Usage: $PROG {start|stop|restart}"
    exit 1
esac

exit 0

