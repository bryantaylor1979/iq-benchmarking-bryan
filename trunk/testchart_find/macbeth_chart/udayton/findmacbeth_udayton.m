function [PASS,new_struct] = findmacbeth_udayton(IMAGE)
%%
I = double(IMAGE);
imagescale = 3;
disp('macbeth find use small scale')
drawnow; 
[X,C] = CCFind(imresize(I,1/imagescale));
X = X*imagescale;

if isempty(X)
    disp('macbeth find use full image')
    drawnow;
    [X,C] = CCFind(I); 
end
if isempty(X)
    PASS = false;
    new_struct = [];
else
    PASS = true;
    new_struct = udayton2generic(X);
end