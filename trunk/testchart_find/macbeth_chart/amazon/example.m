%%
% IMAGE = imread('C:\Users\bryantay\Documents\MATLAB\broadcom\macbeth_cwf.jpg');
IMAGE = imread('C:\Users\bryantay\Documents\MATLAB\broadcom\Mannaquin_6500_50lux.jpg');

%%
imagescale = 8;
printdebug = false
struct = findmacbeth(IMAGE,imagescale,printdebug,[]);
macbethrois(IMAGE,struct)

%%
close all
clear classes
imagename = 'C:\Users\bryantay\Dev\testchart_find\macbeth_chart\images\withmacbeth\macbeth_cwf.jpg'
[PASS,rois] = findmacbeth_amazon(imagename);

%%
imagename = 'C:\Users\bryantay\Dev\testchart_find\macbeth_chart\images\withmacbeth\Mannaquin_6500_50lux.jpg'
IMAGE = imread(imagename);
[PASS,rois] = findmacbeth_udayton(imagename);

%%
new_struct = udayton2generic(rois);
h = plot_macbethrois(IMAGE,new_struct);
saveas(h,'roi_plot.jpg')