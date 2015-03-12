filename = 'City_01.dng'
output = exifread(filename)
output.Thumbnail

%% Doesn't work
output = imfinfo(filename)

%%
image = imread(filename);
imshow(image)

% raw
% jpg res
%    jpg exif
% jpg thumbnail
% json (meta data -tags) 

% exifread - jpg exif


%%
t = Tiff(filename,'r');

%%
imtool(filename)

%%
fid = fopen(filename);
A = fread(fid,[2048 1088*1000],'uint8','l');
fclose(fid);
imshow(uint8(A))