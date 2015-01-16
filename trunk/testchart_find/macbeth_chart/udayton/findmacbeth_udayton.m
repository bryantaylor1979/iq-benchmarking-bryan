function [PASS,X] = findmacbeth_udayton(imagename)
%%
IMAGE = imread(imagename);
I = double(IMAGE);
imagescale = 3;
[X,C] = CCFind(imresize(I,1/imagescale));
X = X*imagescale;

if isempty(X)
    [X,C] = CCFind(I); 
end
if isempty(X)
    PASS = false;
else
    PASS = true;
end