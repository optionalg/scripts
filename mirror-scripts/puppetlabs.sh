#!/bin/bash
# Mirror sync script for Puppet Labs' Enterprise Linux repo

MIRROR='yum.puppetlabs.com'
BASEDIR='/mirror/pub/puppetlabs'
LOCKFILE='/tmp/mirror-scripts-puppetlabs.lck'

[ ! -d $BASEDIR ] && mkdir -p $BASEDIR || :

if [ -f $LOCKFILE ]; then
  echo "Found lock at $LOCKFILE, perhaps something is still syncing."
  exit 1
fi

touch $LOCKFILE

rsync -aqzH --delete --delay-updates $MIRROR::packages/yum/el $BASEDIR/
rsync -aqzH --delete --delay-updates $MIRROR::packages/yum/RPM-GPG-KEY* $BASEDIR/

rm -f $LOCKFILE
