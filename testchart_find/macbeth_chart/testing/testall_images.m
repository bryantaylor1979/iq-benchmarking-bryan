function testall_images(DIR,mode)
images = {  'macbeth_cwf.jpg'; ...
            'Mannaquin_2800_50lux.jpg'; ...
            'Mannaquin_2800_400lux.jpg'; ...
            'Mannaquin_2800_700lux.jpg'; ...
            'Mannaquin_4150_50lux.jpg'; ...
            'Mannaquin_4150_400lux.jpg'; ...
            'Mannaquin_4150_700lux.jpg'; ...
            'Mannaquin_6500_50lux.jpg'; ...
            'Mannaquin_6500_400lux.jpg'; ...
            'Mannaquin_6500_700lux.jpg'};
tic

x = size(images,1);
passedcount = 0;
for i = 1:x
    imagename = fullfile(DIR,images{i});
%     try
    [PASS] = feval(['findmacbeth_',mode],imagename);
%     catch
%     PASS = false;    
%     end
    if PASS == true
        passedcount = passedcount + 1;
        disp([images{i},': PASS'])
    else
        disp([images{i},': FAIL'])
    end
end
disp(['Overall Pass Rate: ',num2str(round(passedcount/x*100)),'%'])
toc
disp(' ')
disp(' ')
end