function struct = ImageInfo()
    DefaultNum = []; 
    
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
    
    for i = 1:24
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).LL.X = DefaultNum;
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).LL.Y = DefaultNum;
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).UL.X = DefaultNum;
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).UL.Y = DefaultNum;
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).LR.X = DefaultNum;
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).LR.Y = DefaultNum;
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).UR.X = DefaultNum;
        struct.ImageInfo.Macbeth.(['Patch',num2str(i)]).UR.Y = DefaultNum;
    end
end
