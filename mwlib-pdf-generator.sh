#!/bin/bash
# mwlib-pdf-generator.sh
# Start the required utilities to generate PDFs for MediaWiki
#
# chkconfig: 345 99 5
# description: starts mwlib pdf generator
# processname: mwlib-pdf-generator.sh
#
# Before using this script, you should have Extension:Collection, mwlib, and
# mwlib.rl installed. For more information, see the following resources:
#
#   http://www.mediawiki.org/wiki/Extension:Collection
#   http://mwlib.readthedocs.org/en/latest/index.html
#

PROG=mwlib-pdf-generator.sh
BASEDIR="/usr/lib/python2.6/site-packages/mwlib-0.15.2-py2.6-linux-x86_64.egg/mwlib"
CACHEDIR="/tmp/mwlibcache"

# Source function library
. /etc/rc.d/init.d/functions

start() {
    echo "Starting $PROG "

    # mw-qserve
    echo -n "Starting mw-qserve... "
    /usr/bin/mw-qserve > /dev/null 2>&1 &
    [ $? = 0 ] && success || failure
    echo

    # nserve
    echo -n "Starting nserve... "
    $BASEDIR/nserve.py > /dev/null 2>&1 &
    [ $? = 0 ] && success || failure
    echo

    # nslave
    [ ! -d $CACHEDIR ] && mkdir -p $CACHEDIR || :
    echo -n "Starting nslave... "
    $BASEDIR/nslave.py --cachedir $CACHEDIR > /dev/null 2>&1 &
    [ $? = 0 ] && success || failure
    echo
}

stop() {
    # mw-qserve
    echo -n "Stopping mw-qserve... "
    killall mw-qserve > /dev/null 2>&1
    [ $? = 0 ] && success || failure
    echo

    # nserve
    echo -n "Stopping nserve... "
    ps aux | grep 'nserve.py' | grep -v grep | awk '{print $2}' | xargs kill {}
    [ $? = 0 ] && success || failure
    echo

    # nslave
    echo -n "Stopping nslave... "
    ps aux | grep 'nslave.py' | grep -v grep | awk '{print $2}' | xargs kill {}
    [ $? = 0 ] && success || failure
    echo
}

case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    *)
        echo "Usage: $PROG {start|stop}"
        exit 1
    ;;
esac

exit 0
