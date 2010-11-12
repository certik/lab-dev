#! /usr/bin/env python

import cgitb
cgitb.enable()

import subprocess

print "Content-type: text/plain"
print

cmd = 'sudo /bin/su git -c "/bin/sh update-hermes-repo.sh"'
print "Running update script."
p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT)
output = p.stdout.read()
print "  Done."
print "Output:"
print output
