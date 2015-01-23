%%
close all
clear classes
ProjectName = 'AmazonAWB';
ProcessAllImage = false;
WorkspacePath = '/home/bryan/AddAWB_Pictures/trunk/';
add_awb_images(WorkspacePath,ProcessAllImage,'Bridge',ProjectName);