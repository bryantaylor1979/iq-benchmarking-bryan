%%
close all
clear classes
ProjectName = 'AmazonAWB';
ProcessAllImage = true;
WorkspacePath = '/home/bryan/AddAWB_Pictures/trunk/';
obj = add_awb_images(WorkspacePath,ProcessAllImage,'Bridge',ProjectName);

%%
system('mkdir /mnt/depart_share/ImageDatabase/AmazonAWB/images');