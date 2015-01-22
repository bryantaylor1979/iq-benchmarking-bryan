classdef add_awb_images < handle
    properties
        ImageDatabaseRoot = '/mnt/depart_share/ImageDatabase/';
    end
    methods
        function obj = add_awb_images(WorkspacePath,ProcessAllImage,PhotoshootName,ProjectName)
            ImageRootPath = fullfile(obj.ImageDatabaseRoot,ProjectName,'tobeadded');
            
            obj.add_all_paths(WorkspacePath);
            
            disp(['Enable: ',num2str(ProcessAllImage)]);
            disp(['PhotoshootName: ',PhotoshootName]);
            
            Names = obj.listofimages(fullfile(ImageRootPath,PhotoshootName),'.jpg')
        end
        function add_all_paths(obj,WorkspacePath)
            addpath(fullfile(WorkspacePath,'add_awb_images'));
            addpath(fullfile(WorkspacePath,'testchart_find'));
            addpath(fullfile(WorkspacePath,'testchart_find','image_tags'));
            addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart'));
            addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','amazon'));
            addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','combined'));
            addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','testing'));
            addpath(fullfile(WorkspacePath,'testchart_find','macbeth_chart','udayton'));            
        end
        function Names = listofimages(obj,Path,ImageType)
            OBJ = ImageIO(  'Path',            Path, ...
                            'EnableFiltering', true, ...
                            'DirectoriesOnly', false, ...
                            'ImageType',       ImageType);   
            OBJ.RUN();
            Names = OBJ.names;
        end
    end
end
