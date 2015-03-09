function [summary] = findmacbeth_andTag(mode,imagename)
    disp(imagename)
    IMAGE = imread(imagename);
    summary.imagename = imagename;
    try
        tic;
        [summary.PASS,struct,integrity] = feval(['findmacbeth_',mode],IMAGE);
        disp(integrity)
    catch
        summary.PASS = false;
        struct =[];
    end
    summary.timetaken = toc;
    if summary.PASS == true            
        SaveVisualisation(IMAGE,imagename,struct);
        writeImageTags(imagename,struct);        
    end
end
function SaveVisualisation(IMAGE,imagename,struct)
    % make results folder if it does not exist. 
    [path,filename,~] = fileparts(imagename);
    if not(isdir(fullfile(path,'Results')))
        mkdir(fullfile(path,'Results'))
    end
    % plot ROIS and save
    visible = 'off';
    suffix = '_MacbethRois.jpg';
    h = plot_macbethrois(IMAGE,struct,visible);
    saveas(h,fullfile(path,'Results',[filename,suffix]));
    close(h);
end