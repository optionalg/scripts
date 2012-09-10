#!/bin/bash
# Mirror sync script for Repoforge (fka RPMforge)

MIRROR='repoforge.eecs.wsu.edu'
BASEDIR='/mirror/pub/repoforge'
RELEASES="5 6"
LOCKFILE='/tmp/mirror-scripts-repoforge.lck'

[ ! -d $BASEDIR ] && mkdir -p $BASEDIR || :

if [ -f $LOCKFILE ]; then
  echo "Found lock at $LOCKFILE, perhaps something is still syncing."
  exit 1
fi

touch $LOCKFILE

for rel in $RELEASES; do
  rsync -aqzH --delete --delay-updates $MIRROR::repoforge/redhat/el$rel $BASEDIR/redhat/
  rsync -aqzH --delete --delay-updates $MIRROR::repoforge/source $BASEDIR/
done

if [ ! -f $BASEDIR/RPM-GPG-KEY.dag.txt ]; then
  wget -O $BASEDIR/RPM-GPG-KEY.dag.txt http://apt.sw.be/RPM-GPG-KEY.dag.txt
fi

rm -f $LOCKFILE
