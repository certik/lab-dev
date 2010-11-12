#! /usr/bin/env sh

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

echo "Updating repository..."
git clean -dfx
git pull origin master

echo "Updating the online lab:"
mkdir $CONFIG_DIR
cp -r ui $CONFIG_DIR/
bin/onlinelab core init --home=$CONFIG_DIR/core-home --ui-path=$CONFIG_DIR/ui
bin/onlinelab service init --home=$CONFIG_DIR/service-home

echo "Starting the online lab:"
bin/onlinelab core start --home=$CONFIG_DIR/core-home
bin/onlinelab service start --home=$CONFIG_DIR/service-home

echo "Update script done."
