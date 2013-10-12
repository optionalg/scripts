#!/bin/bash
# BIND pre-commit hook for Git.
# This file should be renamed and placed at '.git/hooks/pre-commit'

# Check that the necessary tools are in our $PATH
which named-checkzone > /dev/null 2>&1 || exit 1

# Operate on each zone file (*.db) in this repo
for file in $(git diff --cached --name-only --diff-filter=ACM -- '*.db'); do
    zone=`echo ${file} | perl -pe 's/(.*)\.db/$1/'`
    named-checkzone $zone $file
    [ $? != 0 ] && exit 1 || :
done

# No errors were reported, proceed with the commit
exit 0
