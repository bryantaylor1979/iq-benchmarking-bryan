function run_comparison(workspace)
    addpath(workspace);
    amazon = loadfile(   fullfile( workspace, 'amazon',   'summary.mat') );
    udayton = loadfile(  fullfile( workspace, 'udayton',  'summary.mat') );
    combined = loadfile( fullfile( workspace, 'combined', 'summary.mat') );
    plot_radar(workspace,amazon,udayton,combined)
end
function structout = loadfile(filename)
    disp(['loading: ',filename])
    struct = load(filename);
    try
    structout.maxtimetaken = max([ struct.withmacbeth.summary.overall.maxtimetaken, ...
                                   struct.withoutmacbeth.summary.overall.maxtimetaken] );
    structout.postive_test_failrate =  100 - struct.withmacbeth.summary.overall.overallpassrate;
    structout.negative_test_failrate = 100 - struct.withoutmacbeth.summary.overall.overallpassrate;
    structout.positive_averagetime =   struct.withmacbeth.summary.overall.averagetimetaken;
    structout.negative_averagetime =   struct.withoutmacbeth.summary.overall.averagetimetaken;
    catch
    structout.maxtimetaken = max([ struct.withmacbeth.overall.maxtimetaken, ...
                                   struct.withoutmacbeth.overall.maxtimetaken] );
    structout.postive_test_failrate =  100 - struct.withmacbeth.overall.overallpassrate;
    structout.negative_test_failrate = 100 - struct.withoutmacbeth.overall.overallpassrate;
    structout.positive_averagetime =   struct.withmacbeth.overall.averagetimetaken;
    structout.negative_averagetime =   struct.withoutmacbeth.overall.averagetimetaken;        
    end
    disp(' ')
end
function plot_radar(workspace,amazon,udayton,combined)
    disp('plotting radar') 
    gridspace = 5;
    DATA = [ amazon.maxtimetaken   amazon.postive_test_failrate   amazon.negative_test_failrate   amazon.positive_averagetime   amazon.negative_averagetime; ...
             udayton.maxtimetaken  udayton.postive_test_failrate  udayton.negative_test_failrate  udayton.positive_averagetime  udayton.negative_averagetime; ...
             combined.maxtimetaken combined.postive_test_failrate combined.negative_test_failrate combined.positive_averagetime combined.negative_averagetime];

    % normalise against max error.
    disp('create dataset') 
    for i = 1:5
        DATA(:,i) = DATA(:,i)./max(DATA(:,i));
    end
    
    Labels = { 'maxtimetaken'; ...
               '+fail'; ...
               '-fail'; ...
               '+avtime'; ...
               '-avtime'};

    FontSize = 10;
    Color = [0,0,0];
    disp('run plotter') 
    hfig = radarplot(  DATA, ...
                Labels, ...
                {'b','r','g'}, ...
                {'b','r','g'}, ...
                {'no','no','no'}, ...
                gridspace, ...
                FontSize, ...
                Color);
    disp('completed plotter')
    h = legend({'amazon','udayton','combined'});
    set(h,'Location','North');
    saveas(hfig, fullfile(workspace,'radar.jpg') );
end