workspacepath = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace'
addpath(fullfile(workspacepath,'lib'))
addpath(fullfile(workspacepath,'testing'))
DIR = fullfile(workspacepath,'images/withmacbeth/');
testall_images(DIR,'udayton')