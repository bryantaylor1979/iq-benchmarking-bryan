function batch_process_all(DIR,images,mode)
    tic
    x = size(images,1);
    passedcount = 0;
    for i = 1:x
        imagename = fullfile(DIR,images{i});
        IMAGE = imread(imagename);
        try
        [PASS,struct] = feval(['findmacbeth_',mode],IMAGE);
        catch
        PASS = false;    
        end
        if PASS == true
            disp([images{i},': PASS'])
            passedcount = passedcount + 1; 

            % make results folder if it does not exist. 
            [path,filename,ext] = fileparts(imagename);
            if not(isdir(fullfile(path,'Results')))
                mkdir(fullfile(path,'Results'))
            end

            % plot ROIS and save
            visible = 'off';
            suffix = '_MacbethRois.jpg';
            h = plot_macbethrois(IMAGE,struct,visible);
            saveas(h,fullfile(path,'Results',[filename,suffix]))
            close(h);

            writeImageTags(imagename,struct);
        else
            disp([images{i},': FAIL'])
        end
    end
    disp(['Overall Pass Rate: ',num2str(round(passedcount/x*100)),'%'])
    toc
    disp(' ')
    disp(' ')
end