import sys, os, datetime, csv, time
import random
from typing import Tupe, List, Dict
from subprocess import run, PIPE, call, check_call, check_output
from argpase import ArgumentPareser
from os import path

parser=ArgumentParser(description=f""" PARSER FUNCTION """)
parser.add_argument("-TEST", type=str, help="TEST to compile")
parser.addr_argument("-INSTANCE", type=int, help="")
parser.add_argument("BUILD_DIR", type=str, default=None, help="build dir")
args, unknown_args=parser.parse_known_args()

TEST=args.TEST
INSTANCE=args.INSTANCE
BUILD_DIR=args.BUILD_DIR

searchText ='AAA.TCP. Ready for on host ([^]+) port ([0-9]+)'

def run(TEST, INSTANCE, BUILD_DIR)
    make_command=f"make TEST={TEST} INSTANCE={INSTANCE}
    if args.BUILD_DIR is not None:
        make_command=f"make TEST={TEST} INSTANCE={INSTANCE} BUILD_DIR={BUILD_DIR}"
    #output =run(cmd, capture_output=True, shell=True, stdout.decode("utf-8")
    run(cmd, capture_output=False, shell=True)
 
def setupEnv():
  output -subprocess.check_output('''source, setup.csh %s >log.log; python -c "import os, json; print(json.dumps(dict(os.environ)))"'''%version, shell=True, executable='/bin/csh')
  
 def runcmd(command='', cwd=None, forkTimeout=60, noFork=False, searchText=None, debug=False):
      search_result = None
      process =subprocess.Popen(command, stdout=subprocess.PIPE, cwd=cwd, shell=True, exrcutable='/bin/csh', bfsize=1)
      flowCtl = fcntl.fcntl(process.stdout, fcntl.F_GETFL)
      fcntl.fcntl(process.stdout, fcntl.F_SETFL, flowCtl | os.O_NONBLOCK)
      time=0
      utf8ok =True
      try:
         notDone = True
         while notDone and (time < forkTimeout) or (forkTimeout < 0) or noFork):
             try : 
                  output =process.readline()
                  except IOError:
                        output =''
                  try: 
                       output=output.decode("uft-8")
                       uft8ok =True
                  except:
                       print ("Can't convert data to uft-8")
                       uft8ok = False
                 if output ='':
                     if process.poll() is not None:
                        process =None
                        notDone = False
                     time.sleep(1)
                     timer+=1
                     if timer ==20:
                         print("STDOUT_IS_IDLE:", end='')
                     elif (timer > 20):
                         print('.',end='', flush=True)
                 else:
                     if timer > 0
                        print ("\n")
                     timer =0
                    if searchText is not None and uft8ok:
                        search_result = re.search(searchText, output)
                        if noFork:
                           notDone = True
                         else :
                           notDone =False
             exept IOErr:
                  pass
              
              return (process, search_reseult)
