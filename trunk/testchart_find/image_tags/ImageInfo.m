function struct = ImageInfo()
% Written by: Bryan Taylor
    standard = 0.2;
    DefaultNum = 0;
    switch standard
        case 0
            struct = {createRev1(DefaultNum)};
        case 0.2
            struct = {createRev2(DefaultNum)};
        otherwise
    end
end
function struct = createRev1(DefaultNum)
    struct.ImageInfo.HeaderVersion = 1;
    
    struct.ImageInfo.GreyPatchCoords.LL.X = DefaultNum;
    struct.ImageInfo.GreyPatchCoords.LL.Y = DefaultNum;
    struct.ImageInfo.GreyPatchCoords.UL.X = DefaultNum;
    struct.ImageInfo.GreyPatchCoords.UL.Y = DefaultNum;
    struct.ImageInfo.GreyPatchCoords.LR.X = DefaultNum;
    struct.ImageInfo.GreyPatchCoords.LR.Y = DefaultNum;
    struct.ImageInfo.GreyPatchCoords.UR.X = DefaultNum;
    struct.ImageInfo.GreyPatchCoords.UR.Y = DefaultNum;

    struct.ImageInfo.ManualGreyPatchCoords.LL.X = DefaultNum;
    struct.ImageInfo.ManualGreyPatchCoords.LL.Y = DefaultNum;
    struct.ImageInfo.ManualGreyPatchCoords.UL.X = DefaultNum;
    struct.ImageInfo.ManualGreyPatchCoords.UL.Y = DefaultNum;
    struct.ImageInfo.ManualGreyPatchCoords.LR.X = DefaultNum;
    struct.ImageInfo.ManualGreyPatchCoords.LR.Y = DefaultNum;
    struct.ImageInfo.ManualGreyPatchCoords.UR.X = DefaultNum;
    struct.ImageInfo.ManualGreyPatchCoords.UR.Y = DefaultNum;
    
    struct.ImageInfo.Macbeth = createMacbethRev1(DefaultNum);
end
function struct = createRev2(DefaultNum)
    % version
    struct.version.name = 'Amazon DNG metadata';
    struct.version.version = '0.2';
    
    % capture
    struct.capture.ctt = DefaultNum;
    struct.capture.height = DefaultNum;
    struct.capture.lv = DefaultNum;
    struct.capture.width = DefaultNum;
    struct.capture.iso = DefaultNum;
    struct.capture.f_number = DefaultNum;
    struct.capture.exp_time = DefaultNum;
    struct.capture.bayer_order = 'RGGB';
    
    % scene
    struct.scene.chart_regions = {};
    struct.scene.white_point.y = 0;
    struct.scene.white_point.x = 0;
    struct.scene.grey_region_manual{1}{1} = {DefaultNum, DefaultNum};  
    struct.scene.grey_region_awb_test{1}{1} = {DefaultNum, DefaultNum}; 
    struct.scene.macbeth = createMacbethRev2(DefaultNum);
    struct.calibration.channel_sensitivity = {DefaultNum, DefaultNum, DefaultNum, DefaultNum};
end
function new_struct = createMacbethRev1(DefaultNum)
   for i = 1:24
        new_struct.(['Patch',num2str(i)]).LL.X = DefaultNum;
        new_struct.(['Patch',num2str(i)]).LL.Y = DefaultNum;
        new_struct.(['Patch',num2str(i)]).UL.X = DefaultNum;
        new_struct.(['Patch',num2str(i)]).UL.Y = DefaultNum;
        new_struct.(['Patch',num2str(i)]).LR.X = DefaultNum;
        new_struct.(['Patch',num2str(i)]).LR.Y = DefaultNum;
        new_struct.(['Patch',num2str(i)]).UR.X = DefaultNum;
        new_struct.(['Patch',num2str(i)]).UR.Y = DefaultNum;
   end
end
function new_struct = createMacbethRev2(DefaultNum)
    for i = 1:24
        % LL [X,Y]
        new_struct{i}{1} = {DefaultNum, DefaultNum};
        % LR [X,Y]
        new_struct{i}{2} = {DefaultNum, DefaultNum};
        % UR [X,Y]
        new_struct{i}{3} = {DefaultNum, DefaultNum};
        % UL [X,Y]
        new_struct{i}{4} = {DefaultNum, DefaultNum};
    end
end