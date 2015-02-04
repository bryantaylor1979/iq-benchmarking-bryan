classdef test_combined < handle
    properties
        AddPath = true
        workspacepath = '/var/lib/jenkins/jobs/findmacbeth_combined/workspace'
    end
    methods
        function AddPaths(obj,workspacepath)
            addpath(fullfile(workspacepath,'amazon'))
            addpath(fullfile(workspacepath,'combined'))
            addpath(fullfile(workspacepath,'udayton'))
            addpath(fullfile(workspacepath,'testing'))
            addpath(fullfile(workspacepath,'image_tags'));            
        end
        function obj = test_combined(varargin)
            x = size(varargin,2);
            for i = 1:2:x
                obj.(varargin{i}) = varargin{i+1};
            end
            
            if obj.AddPath == true
                obj.AddPaths(obj.workspacepath);
            end
            images = imageset();
            obj.run_batch('withmacbeth',images.with,true);
            obj.run_batch('withoutmacbeth',images.without,false);
        end
        function run_batch(obj,type,images,pos)
            DIR = fullfile(obj.workspacepath,'images',type);
            batch_process_all(DIR,images,'combined',pos);            
        end
    end
end



