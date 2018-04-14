#!/bin/sh

set -e

# Ensure local binaries are in path
PATH=$PATH:/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Set upstream if necessary
git remote | grep -q "upstream" || {
    echo "Added upstream remote."
    git remote add upstream https://github.com/unitedvote/proof-of-vote.git
}

git pull upstream master --ff-only --quiet
git push origin master --quiet
