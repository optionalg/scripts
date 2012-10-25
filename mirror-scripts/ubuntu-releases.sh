#!/bin/bash
# Mirror sync script for specific Ubuntu releases (ISOs)

MIRROR='mirrors.kernel.org'
BASEDIR='/mirror/pub/ubuntu-releases'
RELEASE_CODENAMES="precise"
RELEASE_VERSIONS="12.04"
LOCKFILE='/tmp/mirror-scripts-ubuntu-releases.lck'

[ ! -d $BASEDIR ] && mkdir -p $BASEDIR || :

if [ -f $LOCKFILE ]; then
  echo "Found lock at $LOCKFILE, perhaps something is still syncing."
  exit 1
fi

touch $LOCKFILE

# Copy the file the link references to avoid using the .pool/ directory
for relname in $RELEASE_CODENAMES; do
  rsync -rLtqz --delete --delay-updates $MIRROR::ubuntu-releases/$relname* $BASEDIR/
done

# Preserve the links for release number to release codename directory
for relver in $RELEASE_VERSIONS; do
  rsync -rltqzH --delete --delay-updates $MIRROR::ubuntu-releases/$relver* $BASEDIR/
done

rm -f $LOCKFILE
