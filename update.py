#! /usr/bin/env python

import cgitb
cgitb.enable()

from util import run

print "Content-type: text/plain"
print

#cmd = 'sudo /bin/su ondrej -c "/bin/sh update.sh"'
cmd = '/bin/sh update.sh'
print "Running update script."
output, r = run(cmd, timeout=10)
print "  Done."
print "Return code:", r
print "Output:"
print
print output
print
print "-"*80
if r == -9:
    print "Timeout, process killed."
else:
    print "Return code:", r
