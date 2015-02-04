classdef test_udayton < handle
    properties
        AddPath = true
        workspacepath = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace'
    end
    methods
        function AddPaths(obj,workspacepath)
            addpath(fullfile(workspacepath,'lib'));
            addpath(fullfile(workspacepath,'testing'));
            addpath(fullfile(workspacepath,'image_tags'));           
        end
        function obj = test_udayton(varargin)
            x = size(varargin,2);
            for i = 1:2:x
                obj.(varargin{i}) = varargin{i+1};
            end
            
            if obj.AddPath == true
                obj.AddPaths(obj.workspacepath);
            end
            
            images = imageset();
            struct.withmacbeth.summary    = obj.run_batch('withmacbeth',    images.with,    true);
            struct.withoutmacbeth.summary = obj.run_batch('withoutmacbeth', images.without, false);
            
            save('summary.mat', '-struct', 'struct');
            struct2json(struct.withmacbeth,'withmacbeth_summary.json');
            struct2xml(struct.withmacbeth, 'withmacbeth_summary.xml');
            struct2json(struct.withoutmacbeth,'withoutmacbeth_summary.json');
            struct2xml(struct.withoutmacbeth, 'withoutmacbeth_summary.xml');
        end
        function summary = run_batch(obj,type,images,pos)
            DIR = fullfile(obj.workspacepath,'images',type);
            summary = batch_process_all(DIR,images,'udayton',pos);            
        end
    end
end
