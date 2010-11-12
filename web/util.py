from os import kill
from time import sleep
from signal import alarm, signal, SIGALRM, SIGKILL
from subprocess import PIPE, Popen, STDOUT
from tempfile import SpooledTemporaryFile

def run(args, timeout = 10):
    '''
    Run a command with a timeout after which it will be forcibly
    killed.
    '''
    out_file = SpooledTemporaryFile()
    p = Popen(args, shell=True, stdout=out_file, stderr=STDOUT)
    wait_remaining_sec = timeout
    while p.poll() is None and wait_remaining_sec > 0:
        sleep(1)
        wait_remaining_sec -= 1
    if wait_remaining_sec <= 0:
        kill_proc(p.pid)
        r = -9
    else:
        r = p.returncode
    out_file.seek(0)
    out = out_file.read()
    return out, r

def kill_proc(pid, kill_tree=True):
    pids = [pid]
    if kill_tree:
        pids.extend(get_process_children(pid))
    for pid in pids:
        kill(pid, SIGKILL)

def get_process_children(pid):
    p = Popen('ps --no-headers -o pid --ppid %d' % pid, shell = True,
              stdout = PIPE, stderr = PIPE)
    stdout, stderr = p.communicate()
    return [int(p) for p in stdout.split()]
