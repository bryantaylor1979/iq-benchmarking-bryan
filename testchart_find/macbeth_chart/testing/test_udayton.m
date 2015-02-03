workspacepath = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace'
addpath(fullfile(workspacepath,'lib'));
addpath(fullfile(workspacepath,'testing'));
addpath(fullfile(workspacepath,'image_tags'));

DIR = fullfile(workspacepath,'images/withmacbeth/');
testall_images(DIR,'udayton');

DIR = fullfile(workspacepath,'images/withoutmacbeth/'); 
testall_images(DIR,'udayton');