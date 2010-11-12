#! /usr/bin/env sh

set -e

echo "Running as:"
id
echo "Updating repository..."
cd /home/ondrej/repos/femhub-online-lab
git pull origin master
echo "  Done."
