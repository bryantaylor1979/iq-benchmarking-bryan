workspacepath = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace'
addpath(fullfile(workspacepath,'lib'));
addpath(fullfile(workspacepath,'testing'));
addpath(fullfile(workspacepath,'image_tags'));

images = imageset();

DIR = fullfile(workspacepath,'images/withmacbeth/');
batch_process_all(DIR,images.with,'udayton',true);

DIR = fullfile(workspacepath,'images/withoutmacbeth/'); 
batch_process_all(DIR,images.without,'udayton',false);