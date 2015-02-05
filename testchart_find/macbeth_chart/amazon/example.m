%%
close all
clear classes

%%
imagename = 'C:\Users\bryantay\Dev\testchart_find\macbeth_chart\images\withoutmacbeth\City_01.jpg'
IMAGE = imread(imagename);
[PASS,rois,integrity] = findmacbeth_amazon(IMAGE);