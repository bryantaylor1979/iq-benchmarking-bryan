%%
% IMAGE = imread('C:\Users\bryantay\Documents\MATLAB\broadcom\macbeth_cwf.jpg');
IMAGE = imread('C:\Users\bryantay\Documents\MATLAB\broadcom\Mannaquin_6500_50lux.jpg');

%%
imagescale = 8;
printdebug = false
struct = findmacbeth(IMAGE,imagescale,printdebug,[]);

%%
figure, imagesc(IMAGE);
[y,x,z] = size(IMAGE)
ax=gca;
for i = 1:24
    pos = [(struct(i).X),struct(i).Y];
    imrect(ax,[pos(1),pos(2),1,1]);
    imageROI(1:100,1:100,1) = struct(i).R/256;
    imageROI(1:100,1:100,2) = struct(i).G/256;
    imageROI(1:100,1:100,3) = struct(i).B/256;
%     figure, imshow(imageROI)
end