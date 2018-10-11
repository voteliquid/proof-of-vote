#!/bin/sh

# Stop script if there are any errors.
set -e

# Make sure the update script runs without issue.
echo "Testing update script... \c"
./update-liquid-mirror.sh
echo "Success"

# Get path of current script
fullpath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
cur_dir=`dirname $(fullpath "$0")`

# Ask if we're in the right directory.
echo "\nCurrent path is: $cur_dir"
echo "If you move this directory, your new cronjob will break."
echo "\nIs this directory final? (y/n) \c"
read -n1 answer
if [ "$answer" != "${answer#[Yy]}" ];then
    echo ""
else
    echo "\n\nPlease move the directory first."
    exit 0
fi

# Write out current crontab to temp file.
crontab -l > tmpcron

# Install new cronjob to run every 30 minutes
echo "*/30 * * * * $cur_dir/update-liquid-mirror.sh" >> tmpcron
crontab tmpcron

# Remove temp cron file
rm tmpcron

echo "\nSucessfully installed update-liquid-mirror.sh cronjob."

# TIP: Disable mail alerts by prepending the following to the top of your crontab
# MAILTO=""
