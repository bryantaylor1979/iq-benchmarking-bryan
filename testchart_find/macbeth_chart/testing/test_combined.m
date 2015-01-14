workspacepath = '/var/lib/jenkins/jobs/findmacbeth_combined/workspace'
addpath(fullfile(workspacepath,'lib'))
addpath(fullfile(workspacepath,'testing'))
DIR = fullfile(workspacepath,'images/withmacbeth/');
testall_images(DIR,'combined')