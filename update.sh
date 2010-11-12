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
echo "Updating repository..."
cd /home/ondrej/repos/femhub-online-lab
git pull origin master
echo "  Done."
