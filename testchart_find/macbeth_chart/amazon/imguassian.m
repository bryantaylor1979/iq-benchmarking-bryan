function IMAGE = imguassian(IMAGE)
    % apply a guassian filter to the image. 
    % this will cause a blurring of the image.
    
    % tunable parameters
    MaskSizeLimits = [3,10];
    Image2Mask_Ratio = 50; %mask will be calculated as 1/50 of the x dimension. 
    
    
    % calculate ideal mask size
    [~,ImgXSize,~]=size(IMAGE);
    
    
    MaskSize = min(MaskSizeLimits(2), ImgXSize/Image2Mask_Ratio);
    MaskSize = max(MaskSizeLimits(1),MaskSize);
    
    MaskSizeX = ceil(MaskSize);
    MaskSizeY = ceil(MaskSize/2);
    
    h = fspecial('gaussian', MaskSizeX, MaskSizeY);
    IMAGE = imfilter(IMAGE,h,'same');
end