function Center = findblockcenter(P, C1, C2,AvArea,PrintDebug)
    ImgSize=size(C1);
    MinArea=0.5;
    Area=[];

    if AvArea<700
        MinArea=0.04;
    end

    for i=1:2:length(P)
        Area=[Area;...
            P(i,:)
            P(i,:)+(P(i+1,:)-P(i,:))*2
            ];
    end
    AreaB=floor([max(1,min(Area(:,1))),min(max(Area(:,1)),ImgSize(2)),max(1,min(Area(:,2))),min(max(Area(:,2)),ImgSize(1))]);
    AreaB( AreaB < 1) =1;
    AreaB( AreaB < 1) =1;

    OK=0;

    while OK<2
        TmpI=((double(C1(AreaB(3):AreaB(4),AreaB(1):AreaB(2)))+double(C2(AreaB(3):AreaB(4),AreaB(1):AreaB(2)))));
    %     if isempty(TmpI)
    %         OK=4;
    %         continue;
    %     end
        TmpI=TmpI./max(max(TmpI));

        if PrintDebug ==1
            figure(5);
            hold on;
            line([AreaB(1),AreaB(2),AreaB(2),AreaB(1),AreaB(1)],[AreaB(3),AreaB(3),AreaB(4),AreaB(4),AreaB(3)]);
            hold off;
        end

        STATS=[];
        for Threshold=0.8:-0.1:0.5
            [STATS1,STATS2,Mask1,Mask2]=findstat(TmpI,[],Threshold,[],[],PrintDebug);
            STATS=[STATS;STATS1];
    %     end                %remark for old alg old alg = start from high
    %                        %threshold and stop when you find a patch that isbig enough
    %                        %new - find all patches and select the bigest, and
    %                        %closest to square
    %     STATS1=STATS;      %remark for old alg
            Ind=0;MaxArea=0;
            for i=1:length(STATS1)
                %remark for old alg from here
                SqR=min(STATS1(i).MajorAxisLength/STATS1(i).MinorAxisLength,STATS1(i).MinorAxisLength/STATS1(i).MajorAxisLength);%is it Square
                ArR=STATS1(i).Area/(STATS1(i).MinorAxisLength*STATS1(i).MajorAxisLength);%is it full
                STATS1(i).NormArea=STATS1(i).Area*SqR^2*ArR;
                %remark for old alg up here
                %STATS1(i).NormArea=STATS1(i).Area; % unmark for old alg
                if STATS1(i).NormArea>MaxArea
                    MaxArea=STATS1(i).NormArea;
                    Ind=i;
                end
            end
            MaxArea=STATS1(Ind).Area;
            if MaxArea>AvArea/2  % unmark for old alg
                break            % unmark for old alg
            end                  % unmark for old alg
        end                       % unmark for old alg
        if Ind==0
            Center=[1000,1000];
            OK=4;
        elseif STATS1(Ind).Area > AvArea*1.8 ||STATS1(Ind).Area < AvArea*MinArea || STATS1(Ind).MajorAxisLength/ STATS1(Ind).MinorAxisLength > 2
            OK=OK+1;
            AreaB=floor([max(1,(AreaB(1)+AreaB(2))/2-(AreaB(2)-AreaB(1))),min(ImgSize(2),(AreaB(1)+AreaB(2))/2+(AreaB(2)-AreaB(1))),...
                max(1,(AreaB(3)+AreaB(4))/2-(AreaB(4)-AreaB(3))),min(ImgSize(1),(AreaB(3)+AreaB(4))/2+(AreaB(4)-AreaB(3)))]);
            Center=[0,0];
        else
            Center=STATS1(Ind).Centroid+[AreaB(1),AreaB(3)];
            if PrintDebug ==1
                figure(5);
                hold on;
                plot(Center(1),Center(2),'Xb');
                hold off;
            end

            OK=4;
        end
    end
end
