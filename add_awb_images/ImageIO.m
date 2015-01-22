classdef ImageIO < handle
    properties (SetObservable = true)
        Mode = 'all' %all or ui
        EnableFiltering = true;
        DirectoriesOnly = true;
        Path = 'C:\ISP\awb\'
        ImageType = '.raw'
        names
    end
    properties (Hidden = true)
        log
    end
    methods
        function Example(obj)
            %% Get Folder List. 
            close all
            clear classes
            ProjectName = 'AmazonAWB';
            ImageDatabaseRoot = '/mnt/depart_share/ImageDatabase/'
            ImageRootPath = fullfile(ImageDatabaseRoot,ProjectName,'tobeadded');
            obj = ImageIO(  'Path', ImageRootPath, ...
                            'EnableFiltering',false);
            obj.RUN()
            obj.names
            
            %% Get File List
            close all
            clear classes
            obj = ImageIO(  'Path',            '/mnt/depart_share/ImageDatabase/AmazonAWB/tobeadded/Bridge/', ...
                            'EnableFiltering', true, ...
                            'DirectoriesOnly', false, ...
                            'ImageType','.jpg');   
            obj.RUN();
            obj.names
        end
        function RUN(obj)
            %%
            if strcmpi(obj.Mode,'ui')
                obj.names = obj.SelectImageNamesFromDir(obj.Path,obj.ImageType);
            else
                try
                obj.names = obj.GetImageNamesFromDir(obj.Path,obj.ImageType);
                catch
                obj.names = {};    
                end
            end
            if obj.DirectoriesOnly == true
                obj.names = obj.FilterDirOnly(obj.names);
            end
        end
    end
    methods (Hidden = true)
        function obj = ImageIO(varargin)
            x = size(varargin,2);
            for i = 1:2:x
                obj.(varargin{i}) = varargin{i+1};
            end    
        end
        function names = GetImageNamesFromDir(obj,Path,imagetype)
            % names = GetImageNamesFromDir(obj,Path,imagetype)
            % Written by: bryan taylor
            files = dir(Path);
            filenames = rot90(struct2cell(files),3);
           
            filenames = filenames(3:end,end);
           
            %Filter filenames that are not images.
            if obj.EnableFiltering == true
                x = size(filenames,1);
                for i = 1:x
                    n = findstr(filenames{i},imagetype);
                    if isempty(n)
                    p(i) = 0;
                    else
                    p(i) = 1;
                    end
                end
                if isempty(p)
                   error('No image files found')
                end
                names = filenames(find(p==1));
            else
                names = filenames;
            end    
        end
        function names = SelectImageNamesFromDir(obj,Path,imagetype)
            names = obj.GetImageNamesFromDir(Path,imagetype);
            [s,v] = listdlg('PromptString','Select a file:',...
                            'SelectionMode','multiple',...
                            'ListString',names);
            names = names(s);          
        end      end
    methods (Hidden = true)
        function CheckFileNameExists(obj,path,filename)
            %%
            cd(path)
            filenames = struct2cell(dir);
            filenames = filenames(1,3:end);
           
            x = numel(filenames);
            n = find(strcmpi(filenames,filename));
           
            if isempty(n)
                string = ['File does not exist: ',filename];
                uiwait(msgbox(string));
                error(string);
            end
        end
        function namesout = FilterDirOnly(obj,namesin)
            x = max(size(namesin));
            count = 1;
            for i = 1:x 
               if isdir(fullfile(obj.Path,namesin{i}))
                   namesout{count,1} = namesin{i};
                   count = count + 1;
               end
            end          
        end
    end
end