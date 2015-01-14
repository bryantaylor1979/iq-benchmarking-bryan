workspacepath = '/var/lib/jenkins/jobs/findmacbeth_amazon/workspace'
addpath(fullfile(workspacepath,'lib'))
addpath(fullfile(workspacepath,'testing'))
DIR = fullfile(workspacepath,'images/withmacbeth/');
testall_images(DIR,'amazon')