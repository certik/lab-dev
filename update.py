#! /usr/bin/env python

import cgitb
cgitb.enable()

import subprocess

print "Content-type: text/plain"
print

#cmd = 'sudo /bin/su ondrej -c "/bin/sh update.sh"'
cmd = '/bin/sh update.sh'
print "Running update script."
p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT)
output = p.communicate()[0]
r = p.returncode
print "  Done."
print "Return code:", r
print "Output:"
print output
