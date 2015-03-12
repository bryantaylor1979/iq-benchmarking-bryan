function writeImageTags(imagename,macbeth)
% Written by: Bryan Taylor
    PatchForAWBReg = 22;
    ForceOverwrite = false;

    [path,filename,~] = fileparts(imagename);
    
    try
       jsonfilename = fullfile(path,[filename,'.json']);
    end
    
    if exist(jsonfilename)
       disp('json file already exist. Reading file')
       json = fileread(jsonfilename);
       struct = json2struct2(json);
       disp('complete')
    else
       struct = ImageInfo(); 
    end
    
    if ForceOverwrite == true
       struct = ImageInfo();  
    end
    
    struct{1}.scene.macbeth = macbeth;
    struct{1}.scene.grey_region_awb_test = macbeth{PatchForAWBReg};
    json = struct2json2( struct );
    h = fopen(jsonfilename,'w');
    fprintf(h,json);
    fclose(h);
end