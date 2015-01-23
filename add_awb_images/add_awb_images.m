classdef add_awb_images < handle
    properties
        ImageDatabaseRoot = '/mnt/depart_share/ImageDatabase/';
        ImageType = '.jpg';
    end
    methods
        function obj = add_awb_images(WorkspacePath,ProcessAllImage,PhotoshootName,ProjectName)
            ImageRootPath = fullfile(obj.ImageDatabaseRoot,ProjectName,'tobeadded');
            JenkinsPath = fullfile(obj.ImageDatabaseRoot,ProjectName,'images');
            
            obj.add_all_paths(WorkspacePath);
            disp(['Enable: ',num2str(ProcessAllImage)]);
            if ProcessAllImage == true
                disp(['PhotoshootName: All']);   
            else
                disp(['PhotoshootName: ',PhotoshootName]);
            end
            
            if ProcessAllImage == true
                Names = listallimages(obj,ImageRootPath,obj.ImageType);
                [SUCCESS,MESSAGE,~] = rmdir(JenkinsPath,'s');
                if SUCCESS == 0
                    warning(MESSAGE);
                end
                mkdir(fullfile(obj.ImageDatabaseRoot,ProjectName),'images');
                obj.CopyDate2Folder(JenkinsPath,Names);
            else
                Names = obj.listofimages(fullfile(ImageRootPath,PhotoshootName),obj.ImageType);
                obj.CopyDate2Folder(JenkinsPath,Names);
            end
%             disp(Names)
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
                Dirs = obj.listofdirectories(ImageRootPath);
                x = max(size(Dirs));
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
        function CopyDate2Folder(obj,JenkinsPath,Names)
            %%
            x = max(size(Names));
            for i = 1:x
                source_filename = Names{i};
                [~,filename,ext] = fileparts(source_filename);
                destination_filename = fullfile(JenkinsPath,[filename,ext]);
                [SUCCESS,MESSAGE,~] = copyfile(source_filename,destination_filename,'f');
                if SUCCESS == 0
                    warning(MESSAGE)
                else
                    disp(['Successfully copied: ',filename])
                end
            end
        end
    end
end
