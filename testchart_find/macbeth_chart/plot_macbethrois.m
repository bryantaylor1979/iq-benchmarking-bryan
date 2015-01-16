function h = plot_macbethrois(IMAGE,struct,visible)
    h = figure('visible',visible);
    imagesc(IMAGE);
    ax=gca;
    for i = 1:24
        plotROI(ax,struct.(['Patch',num2str(i)]));
    end
end
function plotROI(axes,patch)
    %%
    pos = [patch.LL.X,patch.LL.Y; ...
           patch.UL.X,patch.UL.Y];
    imline( gca, ...
            pos);
    pos = [patch.LL.X,patch.LL.Y; ...
           patch.LR.X,patch.LR.Y];
    imline( gca, ...
            pos);
    pos = [patch.LR.X,patch.LR.Y; ...
           patch.UR.X,patch.UR.Y];
    imline( gca, ...
            pos);
    pos = [patch.UR.X,patch.UR.Y; ...
           patch.UL.X,patch.UL.Y];
    imline( gca, ...
            pos);
end