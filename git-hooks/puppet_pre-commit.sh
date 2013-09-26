#!/bin/bash
# Puppet pre-commit hook for Git.
# This file should be renamed and placed at '.git/hooks/pre-commit'

# Check that the necessary tools are in our $PATH
which puppet > /dev/null 2>&1 || exit 1
which puppet-lint > /dev/null 2>&1 || exit 1

# Operate on each Puppet manifest (*.pp) in this repo
for file in $(git diff --cached --name-only --diff-filter=ACM -- '*.pp'); do
    puppet parser validate ${file}
    [ $? != 0 ] && exit 1 || :

    puppet-lint --with-filename ${file}
    [ $? != 0 ] && exit 1 || :
done

# No errors were reported, proceed with the commit
exit 0
