function writeImageTags(imagename,macbeth)
    % Written by: bryan taylor
    PatchForAWBReg = 22;
    EnableXML = true;
    EnableJSON = true;

    struct = ImageInfo();
    struct.ImageInfo.Macbeth = macbeth;
    struct.ImageInfo.GreyPatchCoords = macbeth.(['Patch',num2str(PatchForAWBReg)]);
    [~,filename,~] = fileparts(imagename);
    if EnableXML == true
       struct2xml(  struct, [filename,'.xml'] )
    end
    if EnableJSON == true
       struct2json( struct, [filename,'.json'] )
    end
end