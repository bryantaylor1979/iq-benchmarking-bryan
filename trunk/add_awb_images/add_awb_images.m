classdef add_awb_images < handle
    properties
        ImageDatabaseRoot = '/mnt/depart_share/ImageDatabase/';
        ImageType = '.jpg';
    end
    methods
        function obj = add_awb_images(WorkspacePath,ProcessAllImage,PhotoshootName,ProjectName)
            ImageRootPath = fullfile(obj.ImageDatabaseRoot,ProjectName,'tobeadded');
            
            obj.add_all_paths(WorkspacePath);
            disp(['Enable: ',num2str(ProcessAllImage)]);
            disp(['PhotoshootName: ',PhotoshootName]);
            
            if ProcessAllImage == true
                Names = listallimages(obj,ImageRootPath,obj.ImageType)
            else
                Names = obj.listofimages(fullfile(ImageRootPath,PhotoshootName),obj.ImageType);
            end
            disp(Names)
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
            x = max(size(OBJ.names));
            for i = 1:x
            	Names{i,1} = fullfile(Path,OBJ.names{i});
            end
        end
        function Dirs = listofdirectories(obj,Path)
            OBJ = ImageIO(  'Path',            Path, ...
                            'EnableFiltering', false);
            OBJ.RUN();
            Dirs = OBJ.names;
        end
        function Names = listallimages(obj,ImageRootPath,ImageType)
                Dirs = obj.listofdirectories(ImageRootPath) 
                x = max(size(Dirs))
                Names = [];
                for i = 1:x
                    NewNames = obj.listofimages(fullfile(ImageRootPath,Dirs{i}),ImageType);
                    if i == 1
                        Names = NewNames;
                    else
                        Names = [Names;NewNames];
                    end
                end            
        end
    end
end
