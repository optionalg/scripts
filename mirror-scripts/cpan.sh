#!/bin/bash
# Mirror sync script for the Comprehensive Perl Archive Network (CPAN)

MIRROR='mirrors.kernel.org'
BASEDIR='/mirror/CPAN'
LOCKFILE='/tmp/mirror-scripts-cpan.lck'

[ ! -d $BASEDIR ] && mkdir -p $BASEDIR || :

if [ -f $LOCKFILE ]; then
  echo "Found lock at $LOCKFILE, perhaps something is still syncing."
  exit 1
fi

touch $LOCKFILE

rsync -aqzH --delete --delay-updates $MIRROR::CPAN $BASEDIR/

rm -f $LOCKFILE
