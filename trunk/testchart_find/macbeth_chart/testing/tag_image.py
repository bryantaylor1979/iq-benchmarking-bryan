import subprocess
import argparse
import os

def BuildCommand(args):
   command = './run_findmacbeth_andTag.sh "'+str(args.matlab_root)+'" "'+str(args.mode)+'" "'+str(os.path.join(args.image_root,args.image_name))+'"'
   print "command: "+command
   return command

def RunCommand(command):
   subprocess.call(command,shell=True)

def arg_parse():
   # defaults
   matlab_root = '/usr/local/MATLAB/MATLAB_Compiler_Runtime/v83'
   mode = 'combined'; #amazon udayton combined
   image_root = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace/testing/'
   image_name = 'Mannaquin_4150_50lux.jpg'

   # parse
   parser = argparse.ArgumentParser()
   parser.add_argument( '--matlab_root', 
                        default=matlab_root, 
                        type=str, 
                        required=False,
                        help="the root path of the matlab runtime libs")
   parser.add_argument( '--image_name',  
                        default=image_name,
                        type=str,
                        required=False,
                        help="filename of the image to be processed")
   parser.add_argument( '--image_root',  
                        default=image_root,
                        type=str,
                        required=False,
                        help="the root path of the image to be processed")
   parser.add_argument( '--mode',  
                        default=mode,
                        type=str,
                        required=False,
                        help="the method used to find the macbeth chart")
   args = parser.parse_args()
   return args

args = arg_parse()
string = BuildCommand(args)
RunCommand(string)
