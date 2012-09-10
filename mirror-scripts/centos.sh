#!/bin/bash
# Mirror sync script for specific releases of CentOS Linux

MIRROR='mirrors.kernel.org'
BASEDIR='/mirror/centos'
RELEASES="5 6"
LOCKFILE='/tmp/mirror-scripts-centos.lck'

[ ! -d $BASEDIR ] && mkdir -p $BASEDIR || :

if [ -f $LOCKFILE ]; then
  echo "Found lock at $LOCKFILE, perhaps something is still syncing."
  exit 1
fi

touch $LOCKFILE

for rel in $RELEASES; do
  rsync -aqzH --delete --delay-updates $MIRROR::centos/$rel* $BASEDIR/
  rsync -aqzH --delete --delay-updates $MIRROR::centos/RPM-GPG-KEY-CentOS-$rel $BASEDIR/
done

rm -f $LOCKFILE
