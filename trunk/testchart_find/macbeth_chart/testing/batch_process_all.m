function batch_process_all(DIR,images,mode,pol)
    tic
    x = size(images,1);
    passedcount = 0;
    failcount = 0;
    for i = 1:x
        imagename = fullfile(DIR,images{i});
        disp(['processing image: ',imagename])
        IMAGE = imread(imagename);
        try
        [PASS,struct] = feval(['findmacbeth_',mode],IMAGE);
        catch
        PASS = false;    
        end
        if PASS == true
            if pol == true
                disp([images{i},': PASS'])
            else
                disp([images{i},': FAIL'])
            end
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
            failcount = failcount + 1; 
            if pol == true
                disp([images{i},': FAIL'])
            else
                disp([images{i},': PASS'])
            end
        end
        disp('')
        drawnow;
    end
    if pol == true
        disp(['Postive (with macbeth) Overall Pass Rate: ',num2str(round(passedcount/x*100)),'%'])
    else
        disp(['Negative (without macbeth) Overall Pass Rate: ',num2str(round(failcount/x*100)),'%'])
    end
    toc
    disp(' ')
    disp(' ')
end