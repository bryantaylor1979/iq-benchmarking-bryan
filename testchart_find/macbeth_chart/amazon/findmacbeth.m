function Ps= findmacbeth(Img,ImageScale,PrintDebug,Rect)
    OK=0;
    Size=[1 1 3]; % dumy numbers
    OK2=0;
    TriedSmallImage=0;
    MinBlack=30; % 10
    
    while OK2<2
        while OK<2 || (isempty(Rect)&& OK<3) % OK =3 is a flag for success
            if OK==2 && isempty(Rect)
                Rect=floor([Size(2)/5, Size(1)*2/5, Size(2)*4/5, Size(1)*8/9]);
                TriedSmallImage=1;
            end

            Ps=[];

            SubSample=1; % default for RAW
            [~,ImgXSize,~]=size(Img);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Find Filtered Normelized Color Components

            %%
            %3 is the Dimension
            %This will find the brighest pixel of RGB. 
            %It may not always be the same colour. 
            %what effect would this have? 
            I=max(Img,[],3); %3 is the Dimension
            
            %find the max number in the array. 
            %If pixels are clipped this will be full scale deflection
            fsd = max(max(I)); 
            
            % find pixels that have pixel value less than 1/25 of brightest
            % pixel 
            index = I<fsd/25;
            
            % if greater than clip
            I(index)=fsd/25;
            
            % (Red - Green)/ClippedIntensity
            RedNorm  = (double(Img(:,:,1))-double(Img(:,:,2)))./double(I);
            BlueNorm = (double(Img(:,:,3))-double(Img(:,:,2)))./double(I);

            % smooth
            RedNorm = imguassian(RedNorm);
            BlueNorm = imguassian(BlueNorm);
            
            % normalise by brightest pixel
            RedNorm = imcontraststretch(RedNorm);
            BlueNorm = imcontraststretch(BlueNorm);
            
            if PrintDebug == true
            figure(1);image(RedNorm*64); colormap(gray); title('red image map')
            figure(2);image(BlueNorm*64); colormap(gray); title('blue image map')
            end

            
            [STATS10,STATS20,Mask1,Mask2]= findstat(RedNorm,BlueNorm,0.3,I,30,PrintDebug);
            %[STATS11,STATS21,Mask1,Mask2]=FindStat(Clpf,Clpf2,0.5,I,30,PrintDebug);
            [STATS12,STATS22,Mask1,Mask2]= findstat(RedNorm,BlueNorm,0.6,I,30,PrintDebug);
            [STATS13,STATS23,Mask1,Mask2]= findstat(RedNorm,BlueNorm,0.75,I,30,PrintDebug);
            [STATS14,STATS24,Mask1,Mask2]= findstat(RedNorm,BlueNorm,0.8,I,30,PrintDebug);
            [STATS15,STATS25,Mask1,Mask2]= findstat(RedNorm,BlueNorm,0.85,I,30,PrintDebug);


            STATS1=[STATS10;STATS12;STATS13;STATS14;STATS15];
            STATS2=[STATS20;STATS22;STATS23;STATS24;STATS25];
            CandidateRB=findcandidate(STATS1,STATS2,ImgXSize,Mask1,Mask2,PrintDebug);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Weght the Candidates to find the best fit
            if size(CandidateRB,1)==1
                RB=CandidateRB;
                ShapeT(4)=2*STATS1(CandidateRB(3)).MinorAxisLength/STATS1(CandidateRB(3)).MajorAxisLength;% test Quibick and 2X1 shapes
                ShapeT(5)=STATS1(CandidateRB(3)).MinorAxisLength/STATS1(CandidateRB(3)).MajorAxisLength;
                ShapeT(4)=min(ShapeT(4),1/ShapeT(4));
                ShapeT(5)=min(ShapeT(5),1/ShapeT(5));
                if ShapeT(4)>ShapeT(5)
                    BlockDist=1.265;
                else
                    BlockDist=1;
                end
            else
                W=[];
                for i=1:size(CandidateRB,1)
                    Pt=[ceil(STATS2(CandidateRB(i,1)).Centroid(2)),ceil(STATS2(CandidateRB(i,1)).Centroid(1));
                        ceil(STATS2(CandidateRB(i,2)).Centroid(2)),ceil(STATS2(CandidateRB(i,2)).Centroid(1));
                        ceil(STATS1(CandidateRB(i,3)).Centroid(2)),ceil(STATS1(CandidateRB(i,3)).Centroid(1))];

                    R(i)=RedNorm(Pt(3,1),Pt(3,2));
                    BR(i)=BlueNorm(Pt(3,1),Pt(3,2));
                    B1(i)=BlueNorm(Pt(1,1),Pt(1,2));
                    B2(i)=BlueNorm(Pt(2,1),Pt(2,2));
                    RB1(i)=RedNorm(Pt(1,1),Pt(1,2));
                    RB2(i)=RedNorm(Pt(2,1),Pt(2,2));

                    ShapeT(1)=STATS2(CandidateRB(i,1)).MinorAxisLength/STATS2(CandidateRB(i,1)).MajorAxisLength; % assume quibick shape
                    ShapeT(2)=STATS2(CandidateRB(i,2)).MinorAxisLength/STATS2(CandidateRB(i,2)).MajorAxisLength; % assume quibick shape
                    ShapeT(4)=2*STATS1(CandidateRB(i,3)).MinorAxisLength/STATS1(CandidateRB(i,3)).MajorAxisLength;% test Quibick and 2X1 shapes
                    ShapeT(5)=STATS1(CandidateRB(i,3)).MinorAxisLength/STATS1(CandidateRB(i,3)).MajorAxisLength;
                    ShapeT(4)=min(ShapeT(4),1/ShapeT(4));
                    ShapeT(5)=min(ShapeT(5),1/ShapeT(5));
                    if ShapeT(4)>ShapeT(5)
                        BlockDist(i)=1.265;
                    else
                        BlockDist(i)=1;
                    end
                    ShapeT(4)=max(ShapeT(4),ShapeT(5));
                    ShapeT(4)=min(1,ShapeT(4));                                                                  %Select closest to shape
                    ShapeT(3)=mean([STATS2(CandidateRB(i,1)).MinorAxisLength,STATS2(CandidateRB(i,2)).MinorAxisLength])/STATS1(CandidateRB(i,3)).MinorAxisLength;
                    ShapeT(3)=min(ShapeT(3),1/ShapeT(3));
                    Shape(i)=ShapeT(1)+ShapeT(2)+ShapeT(3)+ShapeT(4);

                    DistT(1)=sqrt(sum((STATS2(CandidateRB(i,1)).Centroid-STATS2(CandidateRB(i,2)).Centroid).^2));
                    DistT(2)=sqrt(sum((STATS2(CandidateRB(i,2)).Centroid-STATS1(CandidateRB(i,3)).Centroid).^2));
                    DistT(3)=sqrt(sum((STATS2(CandidateRB(i,1)).Centroid-STATS1(CandidateRB(i,3)).Centroid).^2));

                    Dist1=DistT(1)/(BlockDist(i)*DistT(2));
                    Dist1=max(Dist1,1/Dist1);

                    %         Dist2=DistT(3)/(2*DistT(2));
                    %         Dist2=max(Dist2,1/Dist2);
                    %Dist(i)=Dist1;%+Dist2;
                    Dist(i)=Dist1+(DistT(3)<1.3*DistT(2))+(DistT(3)>1.8*DistT(2)); % new condition, may need to be smothed later on ( 7/11/11)

                    D1=(STATS2(CandidateRB(i,2)).Centroid-STATS2(CandidateRB(i,1)).Centroid);
                    D3=(STATS1(CandidateRB(i,3)).Centroid-STATS2(CandidateRB(i,1)).Centroid);
                    A1=atan2(D1(2),D1(1));
                    A2=atan2(D3(2),D3(1));
                    if mod(A1-A2,2*pi)>pi && mod(A1-A2,2*pi)<2*pi-0.2 % more then 10%
                        Angle=1;
                    else
                        Angle=-1;
                    end


                    W(i)=R(i)+B1(i)+B2(i)-abs(RB1(i))-abs(RB2(i))+Shape(i)-Dist(i)-abs(BR(i))+Angle; % (B1(i)>B2(i))+;
                end
                if isempty(W)
                    if OK<2
                        OK=OK+1;
                        continue
                    else
                        clear I C Clpf Clpf2 Y Yr SubImg Img
                        return
                    end
                end;
                Wm=find (W==max(W));
                RB=CandidateRB(Wm(1),:);
                BlockDist=BlockDist(Wm(1));
            end

            if PrintDebug ==1
                PlotArea(2,4,Mask1,Mask2,STATS1,STATS2,RB)
            end

            Ans=[STATS2(RB(1)),STATS2(RB(2)),STATS1(RB(3))];

            if BlockDist>1
                Area3=Ans(3).Area/2;
                Ans(3).MinorAxisLength=max(Ans(3).MinorAxisLength,Ans(3).MajorAxisLength);

            else
                Area3=Ans(3).Area;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Estimate Chart position for best candidate
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% and Cut a Sub Image with the chart
            % OK =0;
            % while OK<2

            Area=mean([Ans(1).Area,Ans(2).Area]);
            AreaRatio(1)=Ans(1).Area/Ans(2).Area;
            AreaRatio(2)=Ans(2).Area/Ans(1).Area;
            AreaRatio(3)=Area3/Ans(1).Area;
            AreaRatio(4)=Area3/Ans(2).Area;
            AreaRatio(5)=Ans(1).Area/Area3;
            AreaRatio(6)=Ans(2).Area/Area3;

            ShapeRatio(1)=Ans(1).MajorAxisLength/Ans(1).MinorAxisLength;
            ShapeRatio(2)=Ans(2).MajorAxisLength/Ans(2).MinorAxisLength;
            ShapeRatio(3)=Ans(3).MajorAxisLength/Ans(3).MinorAxisLength;

            ShapeR=max(ShapeRatio);
            AraeR=max(AreaRatio);

            if Area<90 || AraeR>4 || ShapeR>2.5
                if OK>1
                    clear I C Clpf Clpf2 Y Yr SubImg Img
                    return
                end
                OK=OK+1;
            elseif Area<200 && OK==0
                OK=OK+1;
            else
                OK=3;
            end
        end
    %     if isempty(BlockDist)
    %         OK2=OK2+2;
    %         continue
    %     end
        if BlockDist>1 %Ans(3).Area > Area*1.5 % && Area<1500 % it means that the two reds were detected as on, and the center is in between
            % the 1550 size condition was given
            % assumeing that in small foot print of
            % macbeth the two areas might merge, and in
            % bigones it will not. when using
            % nonstatndard macbethe they merge even if
            % the sise is bigger
            RefPoints=[13,8,29];
        else
            RefPoints=[13,8,15];
        end
        [Corner,P,Flag]=findrect(Ans,[],RefPoints);

        Area=mean([Ans(1).Area,Ans(2).Area,Area3]);

        if PrintDebug ==1
            figure(5);
            image(double(Img)/double(max(max(max(Img)))));hold on;
            line(Corner(:,1),Corner(:,2));
            plot(P(:,1),P(:,2),'*R');
            %line([AreaB(1),AreaB(2),AreaB(2),AreaB(1),AreaB(1)],[AreaB(3),AreaB(3),AreaB(4),AreaB(4),AreaB(3)]);
            hold off;
        end


        Ans2(1,:)   = findblockcenter(P([11,12,23,24],:), -RedNorm, BlueNorm,Area,PrintDebug); %Cyan
        Ans2(2,:)   = findblockcenter(P([11,5,12,6,5,6,11,12],:), -RedNorm, double(Img(:,:,3))/255,Area,PrintDebug); %light Blue
        Ans2(3,:)   = findblockcenter(P([2,1,14,13],:), RedNorm, -BlueNorm, Area,PrintDebug); %orange
        Ans2(4,:)   = findblockcenter(P([13,19,14,20,14,13,20,19],:), Img(:,:,2),Img(:,:,2),Area,PrintDebug); %orange

        if (sum(diff(Ans2(1:2,:)).^2).^0.5/sum(diff(P([6,18],:)).^2).^0.5 <0.5) %we may detect the lower blue - 18 when the upper -6 is saturated
            Ans2(2,:)=[ 0 0];

        end

        if sum(Ans2(1,:)==[1000 1000])==2 || sum(Ans2(2,:)==[1000 1000])==2 || sum(Ans2(3,:)==[1000 1000])==2 || sum(Ans2(4,:)==[1000 1000])==2
            clear I C Clpf Clpf2 Y Yr SubImg Img
            return
        end

        OK2=OK2+2;
        [Corner,P,Flag]=findrect(Ans,Ans2,RefPoints);
        if Flag==1
            [Corner,P,Flag]=findrect(Ans,[],RefPoints);
            if OK2==2
                if isempty(Rect)
                    SizeT=[1 1 Size(2) Size(1)];
                else
                    SizeT=Rect;
                end
                RectSize=max(max(Corner(:,1))-min(Corner(:,1)),max(Corner(:,2))-min(Corner(:,2)));
                RectT=floor([min(Corner(:,1))-RectSize*0.3,min(Corner(:,2))-RectSize*0.3,max(Corner(:,1))+RectSize*0.3,max(Corner(:,2))+RectSize*0.3]);
                RectT=RectT*RealSubSample+[SizeT(1),SizeT(2),SizeT(1),SizeT(2)];
                RectT=max(RectT,[SizeT(1),SizeT(2),SizeT(1),SizeT(2)]);
                RectT(3)=min(RectT(3),SizeT(3));
                RectT(4)=min(RectT(4),SizeT(4));
                Rect=RectT;

                MinBlack=30;
                OK2=OK2-1;
                OK=1;
                continue; % while OK2
            end
        end


        if Flag==0

            if PrintDebug ==1
                figure(5);
                image(double(Img)/double(max(max(max(Img)))));hold on;
                line(Corner(:,1),Corner(:,2));
                plot(P(:,1),P(:,2),'*R');
                %line([AreaB(1),AreaB(2),AreaB(2),AreaB(1),AreaB(1)],[AreaB(3),AreaB(3),AreaB(4),AreaB(4),AreaB(3)]);
                hold off;
            end
            % end
            % locate loack 18 ( cyan )



            Bound=max((max(P(:,1))-min(P(:,1)))/20,5);
            BB=ceil([max(1,min(P(:,1))-Bound),...
                max(min(P(:,2))-Bound,1),...
                min(max(P(:,1))+Bound,size(Img,2)),...
                min(max(P(:,2))+Bound,size(Img,1))]);

            P(P<Bound)=Bound;
            X=P(:,1);
            Y=P(:,2);
            X(X>size(Img,2)-5)=size(Img,2)-5;
            Y(Y>size(Img,1)-5)=size(Img,1)-5;
            P=[X,Y];

            SubImg=Img(BB(2):BB(4),BB(1):BB(3),:);
            %     Y=max(SubImg,[],3);
            %
            %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Find base rotation of the chart ( deg)
            %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% And define chart location and properties
            %     [Angle,Yr]=FindRotation(Y,-10:0.5:10);


            [P,Ps,Pc]=findchart(SubImg,BB,P(1:24,:));


            if PrintDebug>0
                %Img(BB(2):BB(4),BB(1):BB(3),:)=SubImg;
                h=figure(6);hold off;image(double(Img)/double(max(max(max(Img)))));hold on;
                plot(P(:,1),P(:,2),'Xr',Pc(:,1),Pc(:,2),'Og');
                MinX=100000;
                MaxX=0;
                MinY=100000;
                MaxY=0;
                for i=1:length(Ps)
                    line([Ps(i).BoundedBox(1),Ps(i).BoundedBox(1),Ps(i).BoundedBox(3),Ps(i).BoundedBox(3),Ps(i).BoundedBox(1)],...
                        [Ps(i).BoundedBox(2),Ps(i).BoundedBox(4),Ps(i).BoundedBox(4),Ps(i).BoundedBox(2),Ps(i).BoundedBox(2)]);
                    MinX=min([MinX,Ps(i).BoundedBox(1),Ps(i).BoundedBox(1),Ps(i).BoundedBox(3),Ps(i).BoundedBox(3),Ps(i).BoundedBox(1)]);
                    MaxX=max([MaxX,Ps(i).BoundedBox(1),Ps(i).BoundedBox(1),Ps(i).BoundedBox(3),Ps(i).BoundedBox(3),Ps(i).BoundedBox(1)]);
                    MinY=min([MinY,Ps(i).BoundedBox(2),Ps(i).BoundedBox(4),Ps(i).BoundedBox(4),Ps(i).BoundedBox(2),Ps(i).BoundedBox(2)]);
                    MaxY=max([MaxY,Ps(i).BoundedBox(2),Ps(i).BoundedBox(4),Ps(i).BoundedBox(4),Ps(i).BoundedBox(2),Ps(i).BoundedBox(2)]);
                end
                a=get(h);
                XLim=get(a.Children(1),'XLim');
                YLim=get(a.Children(1),'YLim');
                MinX1=max(MinX-(MaxX-MinX),XLim(1));
                MaxX1=min(MaxX+(MaxX-MinX),XLim(2));
                MinY1=max(MinY-(MaxY-MinY),YLim(1));
                MaxY1=min(MaxY+(MaxY-MinY),YLim(2));
                set(a.Children(1),'XLim', [MinX1,MaxX1]);
                set(a.Children(1),'YLim', [MinY1,MaxY1]);
                %axis('image');

            end

            if isempty(Rect)
                Rect=[0 0 0 0];
            end
            for i=1:length(Ps)
                Ps(i).Area =Ps(i).Area*SubSample^2;
                Ps(i).Centroid =Ps(i).Centroid.*SubSample+Rect(1:2);
                Ps(i).BoundingBox =Ps(i).BoundingBox.*SubSample;%+[Rect(1:2),Rect(1:2)];%need to check if it is [X Y L H]
                if ~isempty(Ps(i).BoundingBox)
                    Ps(i).BoundingBox=Ps(i).BoundingBox+[Rect(1:2),Rect(1:2)];
                end
                Ps(i).X =Ps(i).X*SubSample+Rect(1);
                Ps(i).Y =Ps(i).Y*SubSample+Rect(2);
                Ps(i).BoundedBox=Ps(i).BoundedBox.*SubSample;%+[Rect(1:2),Rect(1:2)];%need to check if it is [X Y L H]
                if ~isempty(Ps(i).BoundedBox)
                    Ps(i).BoundedBox=Ps(i).BoundedBox+[Rect(1:2),Rect(1:2)];
                end
            end
            % test results
            WB.R=Ps(22).G/Ps(2).R;
            WB.B=Ps(22).G/Ps(2).B;

            Msr(1)=min([Ps(19).R/Ps(24).R,Ps(19).G/Ps(24).G,Ps(19).B/Ps(24).B]);
            Msr(1)=Msr(1)>1.5;
    %         Msr(2)=Ps(14).G>Ps(14).R*WB.R*1.1;
    %         Msr(3)=Ps(17).R*WB.R>Ps(17).G*1.1;
    %         Msr(4)=Ps(18).B>Ps(18).R*WB.R*1.1;

            Msr(2)=Ps(14).G>Ps(14).R*WB.R;
            Msr(3)=Ps(17).R>Ps(17).G*WB.R;
            Msr(4)=Ps(18).B>Ps(18).R*WB.R;

            %display(sprintf('old Msr= %d new Msr = %d', min(Msr1),min(Msr)));
            Ok=min(Msr);
            if ~Ok
                Ps=[];
            end
        else
            Ps=[]; % not returning earlier to anable the clear command
        end

        if isempty(Ps)
            if ~TriedSmallImage % if we didn't try small imagebefore , try again
               OK=2;
               OK2=0;
               Rect=[];
            end
        end
    end % while OK2
end