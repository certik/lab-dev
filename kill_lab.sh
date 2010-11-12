#! /usr/bin/env sh

# This script kills the lab processes. It is for debugging purposes only, don't
# use this for production.

set -e

# Change this to the current user, that owns the repos:
user_allowed="ondrej"


user=`id -un`
echo "Running as: $user"
# Make sure that we run as $user_allowed
if [ "$user" != "$user_allowed" ]; then
    echo "id != $user_allowed, exiting..."
    exit 1
fi

export PYTHONPATH=/home/ondrej/usr/lib/python:$PYTHONPATH

CONFIG_DIR=c
cd /home/ondrej/repos/femhub-online-lab
echo "Killing the old lab:"
bin/onlinelab service stop --home=$CONFIG_DIR/service-home
bin/onlinelab core stop --home=$CONFIG_DIR/core-home
echo "Print all running online lab processes (should only show 'grep onlinelab')"
ps aux | grep onlinelab

echo "Done."
