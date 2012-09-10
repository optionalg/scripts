#!/bin/bash
# Mirror sync script for Fedora's Extra Packages for Enterprise Linux (EPEL)

MIRROR='mirrors.rit.edu'
BASEDIR='/mirror/epel'
RELEASES="5 6"
LOCKFILE='/tmp/mirror-scripts-epel.lck'

[ ! -d $BASEDIR ] && mkdir -p $BASEDIR || :

if [ -f $LOCKFILE ]; then
  echo "Found lock at $LOCKFILE, perhaps something is still syncing."
  exit 1
fi

touch $LOCKFILE

for rel in $RELEASES; do
  rsync -aqzH --delete --delay-updates $MIRROR::epel/$rel* $BASEDIR/
  rsync -aqzH --delete --delay-updates $MIRROR::epel/RPM-GPG-KEY-EPEL-$rel* $BASEDIR/
done

rm -f $LOCKFILE
