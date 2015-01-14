function [STATS1,STATS2,Mask1,Mask2]=findstat(Clpf,Clpf2,Threshold,I,Threshold2,PrintDebug)
    Mask1=Clpf>Threshold;
    CC = bwconncomp(Mask1,4);
    STATS1 = regionprops(CC, {'Area','Centroid','BoundingBox','MajorAxisLength','MinorAxisLength'});

    if PrintDebug==1
        figure(2);image(Mask1*64);colormap(gray)
    end

    if ~isempty(Clpf2)
        Mask2=Clpf2>Threshold;

        if PrintDebug==1
            figure(4);image(Mask2*64);colormap(gray);
        end
        CC = bwconncomp(Mask2,4);
        STATS2 = regionprops(CC, {'Area','Centroid','BoundingBox','MajorAxisLength','MinorAxisLength'});
    else
        Mask2=[];
        STATS2=[];
    end
end
