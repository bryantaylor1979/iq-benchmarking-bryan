function summary = batch_process_all(DIR,images,mode,pol)
    tstart = tic;
    x = size(images,1);
    for i = 1:x
        imagename = fullfile(DIR,images{i});
        image_summary(i) = findmacbeth_andTag(mode,imagename);
        LogImageSummary(imagename,image_summary(i),tstart);
    end
    
    %%
    summary.tableofresults = image_summary;
    summary.overall = LogAllSummary(image_summary,pol,tstart);
end
function LogImageSummary(imagename,summary,pol)
    if summary.PASS == true
        if pol == true
            disp([imagename,': PASS']);
        else
            disp([imagename,': FAIL']);
        end
    else
        if pol == true
            disp([imagename,': FAIL']);
        else
            disp([imagename,': PASS']);
        end
    end
end
function summary_out = LogAllSummary(summary,pol,tstart)
    %%
    x = size(summary,2);
    for i = 1:x
        PASSES(i) = summary(i).PASS;
        timetaken_array(i) = summary(i).timetaken;
    end
    summary_out.detected_count = sum(PASSES);
    summary_out.maxtimetaken = max(timetaken_array);
    summary_out.mintimetaken = min(timetaken_array);
    summary_out.averagetimetaken = mean(timetaken_array);
    summary_out.nondetected_count = x-summary_out.detected_count;
    
    %%
    if pol == true
        summary_out.overallpassrate = round(summary_out.detected_count/x*100);
        disp(['Postive (with macbeth) Overall Pass Rate: ',num2str(summary_out.overallpassrate),'%'])
    else
        summary_out.overallpassrate = round(summary_out.nondetected_count/x*100);
        disp(['Negative (without macbeth) Overall Pass Rate: ',num2str(summary_out.overallpassrate),'%'])
    end
    summary_out.telapsed = toc(tstart);
    disp(['Time Elapsed: ',num2str(summary_out.telapsed)]);
    disp(['Max Time Taken: ',num2str(summary_out.maxtimetaken)]);
    disp(['Min Time Take: ',num2str(summary_out.mintimetaken)]);
    disp(['Average Time Take: ',num2str(summary_out.averagetimetaken)]);
    disp(' ')
    disp(' ')
end