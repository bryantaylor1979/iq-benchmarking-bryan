workspacepath = '/var/lib/jenkins/jobs/findmacbeth_combined/workspace'
addpath(fullfile(workspacepath,'amazon'))
addpath(fullfile(workspacepath,'combined'))
addpath(fullfile(workspacepath,'udayton'))
addpath(fullfile(workspacepath,'testing'))
addpath(fullfile(workspacepath,'image_tags'));

images = imageset();

DIR = fullfile(workspacepath,'images/withmacbeth/');
batch_process_all(DIR,images.with,'combined',true);

DIR = fullfile(workspacepath,'images/withoutmacbeth/'); 
batch_process_all(DIR,images.without,'combined',false);