mcc -m findmacbeth_andTag findmacbeth_combined findmacbeth_amazon findmacbeth_udayton

%% 
version = 'v2';
root_path = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace/testing'
dest_path = '/mnt/depart_share/HeatScore/add_images'

filelist = {'findmacbeth_andTag'; ...
            'run_findmacbeth_andTag.sh'; ...
            'Mannaquin_4150_50lux.jpg'; ...
            'readmeplease.txt'; ...
            'tag_image.py'};
        
for i = 1:max(size(filelist))
    if not(isdir(fullfile(dest_path,version)))
        mkdir(fullfile(dest_path,version))
    end
    copyfile(fullfile(root_path,filelist{i}),fullfile(dest_path,version))
end