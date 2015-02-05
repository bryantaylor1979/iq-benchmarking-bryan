function [PASS, new_struct, integrity] = findmacbeth_udayton(varargin)
%%
args.flat_scene_threshold = Inf;
IMAGE = varargin{1};
varargin = varargin(2:end);
x = size(varargin,2);
for i = 1:2:x
   args.(varargin{i}) = varargin{i+1};
end

integrity.nopatchesfound = NaN;
integrity.Fidality = NaN;

I = double(IMAGE);
imagescale = 3;
disp('macbeth find use small scale');
drawnow; 

[X,C] = CCFind(imresize(I,1/imagescale),args.flat_scene_threshold);
X = X*imagescale;

if isempty(X)
    disp('macbeth find use full image')
    drawnow;
    [X,C] = CCFind(I,Inf); 
end
if isempty(X)
    PASS = false;
    new_struct = [];
else
    PASS = true;
    integrity.nopatchesfound = size(X)
    new_struct = udayton2generic(X);
end