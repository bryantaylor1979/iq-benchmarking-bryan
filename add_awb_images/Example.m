%%
close all
clear classes
ProjectName = 'AmazonAWB';
ProcessAllImage = true;
WorkspacePath = '/home/bryan/AddAWB_Pictures/trunk/';
add_awb_images(WorkspacePath,ProcessAllImage,'Bridge',ProjectName);