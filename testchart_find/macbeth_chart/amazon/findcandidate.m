function CandidateRB=findcandidate(STATS1_t,STATS2_t,ImgXSize,Mask1,Mask2,PrintDebug)
    CandidateRB=[];
    MinArea=10;%(ImgXSize/250)^2;
    STATS1=[];%STATS1_t;%[];
    Idx1=[];
    STATS2=[];%STATS2_t;%[];
    Idx2=[];
    for i=1:size(STATS1_t,1)
        if STATS1_t(i).Area>MinArea;
            STATS1=[STATS1;STATS1_t(i)];
            Idx1=[Idx1;i];
        end
    end
    for i=1:size(STATS2_t,1)
        if STATS2_t(i).Area>MinArea;
            STATS2=[STATS2;STATS2_t(i)];
            Idx2=[Idx2;i];
        end
    end

    if (size(STATS2,1)+size(STATS1,1)) < 2500
        for i=1:size(STATS2,1)
            for j=1:size(STATS2,1)

                if normdist(STATS2(j),STATS2(i),1,2.5,0,0,MinArea) %1,-1)
                    for k=1:size(STATS1,1)

                        if normdist(STATS1(k),STATS2(i),1.5,3.5,0, 0,MinArea)%1,0)
                            CandidateRB(end+1,:)=[Idx2(i),Idx2(j),Idx1(k)];
                            if PrintDebug==1
                                PlotArea(2,4,Mask1,Mask2,STATS1,STATS2,[i,j,k]);
                            end
                        end
                    end
                end
            end


        end
    end
end
