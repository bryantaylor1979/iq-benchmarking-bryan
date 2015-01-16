function writeImageTags(imagename,macbeth)
    % Written by: bryan taylor
    PatchForAWBReg = 22;
    EnableXML = true;
    EnableJSON = true;

    struct = ImageInfo();
    struct.ImageInfo.Macbeth = macbeth;
    struct.ImageInfo.GreyPatchCoords = macbeth.(['Patch',num2str(PatchForAWBReg)]);
    [path,filename,~] = fileparts(imagename);
    if EnableXML == true
       struct2xml(  struct, fullfile(path,[filename,'.xml']) )
    end
    if EnableJSON == true
       struct2json( struct, fullfile(path,[filename,'.json']) )
    end
end