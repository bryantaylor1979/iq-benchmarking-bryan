%%
close all
clear classes
imagename = 'C:\Users\bryantay\Dev\testchart_find\macbeth_chart\images\withmacbeth\macbeth_cwf.jpg';
IMAGE = imread(imagename);
[PASS,rois] = findmacbeth_combined(IMAGE)