function writeImageTags(imagename,macbeth)
    % Written by: bryan taylor
    PatchForAWBReg = 22;
    EnableXML = true;
    EnableJSON = true;
    ForceOverwrite = false;

    [path,filename,~] = fileparts(imagename);
    xmlfilename = fullfile(path,[filename,'.xml']);
    jsonfilename = fullfile(path,[filename,'.json']);
    if exist(xmlfilename)
       disp('reading existing xml file')
       struct = xml2struct(xmlfilename);
    else
       struct = ImageInfo(); 
    end
    if ForceOverwrite == true
       struct = ImageInfo();  
    end
    struct.ImageInfo.Macbeth = macbeth;
    struct.ImageInfo.GreyPatchCoords = macbeth.(['Patch',num2str(PatchForAWBReg)]);
    
    if EnableXML == true
       struct2xml(  struct, xmlfilename ) 
    end
    if EnableJSON == true
       struct2json( struct, jsonfilename ) 
    end
end