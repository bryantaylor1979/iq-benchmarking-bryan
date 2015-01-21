function add_awb_images(ProcessAllImage)
    ImageRootPath = '/mnt/depart_share/ImageDatabase/AmazonAWB/tobeadded/';
    WorkspacePath = '/var/lib/jenkins/jobs/findmacbeth_amazon/workspace/';
    WorkspacePath = '/home/bryan/AddAWB_Pictures/trunk/';
    addpath(fullfile(WorkspacePath,'add_awb_images'))
    addpath(fullfile(WorkspacePath,'testchart_find'))
    addpath(fullfile(WorkspacePath,'testchart_find','image_tags'))
    addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart'))
    addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','amazon'))
    addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','combined'))
    addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','testing'))
    addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','udayton'))
    disp(['Enable: ',num2str(ProcessAllImage)])
end