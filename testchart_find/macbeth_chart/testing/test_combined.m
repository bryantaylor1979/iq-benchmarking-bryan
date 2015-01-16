workspacepath = '/var/lib/jenkins/jobs/findmacbeth_combined/workspace'
addpath(fullfile(workspacepath,'amazon'))
addpath(fullfile(workspacepath,'combined'))
addpath(fullfile(workspacepath,'udayton'))
addpath(fullfile(workspacepath,'testing'))
DIR = fullfile(workspacepath,'images/withmacbeth/');
addpath(fullfile(workspacepath,'image_tags'));
testall_images(DIR,'combined')