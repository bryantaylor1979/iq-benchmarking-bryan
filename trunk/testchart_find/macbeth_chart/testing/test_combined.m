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
            struct.withmacbeth.summary = obj.run_batch('withmacbeth', images.with, true);
            struct.withoutmacbeth.summary = obj.run_batch('withoutmacbeth', images.without, false);
            
            disp(['Summary Location: ',fullpath(obj.workspacepath,'summary.mat')])
            save(fullpath(obj.workspacepath,'summary.mat'), '-struct', 'struct');
            
            struct2.summary = struct.withmacbeth;
            struct2json(struct2, fullpath(obj.workspacepath,'withmacbeth_summary.json'));
            
            struct2.summary = struct.withoutmacbeth;
            struct2json(struct2, fullpath(obj.workspacepath,'withoutmacbeth_summary.json'));
            disp('write finished')
        end
        function summary = run_batch(obj,type,images,pos)
            DIR = fullfile(obj.workspacepath,'images',type);
            summary = batch_process_all(DIR,images,'combined',pos);            
        end
    end
end



