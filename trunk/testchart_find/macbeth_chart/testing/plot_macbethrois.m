function h = plot_macbethrois(IMAGE,struct,visible)
    h = figure('visible',visible);
    imagesc(IMAGE);
    ax=gca;
    for i = 1:24
        plotROI(ax,struct{i});
    end
end
function plotROI(axes,patch)
    %%
    % LL,UL
    pos = [patch{1}(1), patch{1}(2); ...
           patch{2}(1), patch{2}(2)];
    imline( gca, ...
            pos);
    % LL,UR
    pos = [patch{2}(1), patch{2}(2); ...
           patch{3}(1), patch{3}(2)];
    imline( gca, ...
            pos);
    pos = [patch{3}(1), patch{3}(2); ...
           patch{4}(1), patch{4}(2)];
    imline( gca, ...
            pos);
    pos = [patch{4}(1), patch{4}(2); ...
           patch{1}(1), patch{1}(2)];
    imline( gca, ...
            pos);
end