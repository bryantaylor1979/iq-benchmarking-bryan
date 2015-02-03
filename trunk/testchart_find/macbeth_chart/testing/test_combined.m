workspacepath = '/var/lib/jenkins/jobs/findmacbeth_combined/workspace'
addpath(fullfile(workspacepath,'amazon'))
addpath(fullfile(workspacepath,'combined'))
addpath(fullfile(workspacepath,'udayton'))
addpath(fullfile(workspacepath,'testing'))
addpath(fullfile(workspacepath,'image_tags'));

DIR = fullfile(workspacepath,'images/withmacbeth/');
testall_images(DIR,'combined');

DIR = fullfile(workspacepath,'images/withoutmacbeth/'); 
testall_images(DIR,'combined');