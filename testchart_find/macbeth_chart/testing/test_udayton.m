workspacepath = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace'
addpath(fullpath(workspacepath,'lib'))
addpath(fullpath(workspacepath,'testing'))
DIR = fullpath(workspacepath,'images\withmacbeth\');
testall_images(DIR,'udayton')