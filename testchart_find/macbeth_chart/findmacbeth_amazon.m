function [PASS] = findmacbeth_amazon(imagename)
%%
IMAGE = imread(imagename);
imagescale = 8;
printdebug = false;
struct = findmacbeth(IMAGE,imagescale,printdebug,[]);
if isempty(struct)
    PASS = false;
else
    PASS = true;
end