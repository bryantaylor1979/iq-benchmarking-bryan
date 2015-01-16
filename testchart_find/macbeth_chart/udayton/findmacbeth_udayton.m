function [PASS,new_struct] = findmacbeth_udayton(IMAGE)
%%
I = double(IMAGE);
imagescale = 3;
[X,C] = CCFind(imresize(I,1/imagescale));
X = X*imagescale;

if isempty(X)
    [X,C] = CCFind(I); 
end
if isempty(X)
    PASS = false;
    new_struct = [];
else
    PASS = true;
    new_struct = udayton2generic(X,'method2');
end