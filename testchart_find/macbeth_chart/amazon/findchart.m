        function [P,Po,Pc]=findchart(SubImg,Offset,P)
            ColorCIE1931Names=[...
                {'dark skin'}
                {'light skin'}
                {'blue sky'}
                {'foliage'}
                {'blue flower'}
                {'bluish green'}
                {'orange'}
                {'purplish blue'}
                {'moderate red'}
                {'purple'}
                {'yellow green'}
                {'orange yellow'}
                {'blue'}
                {'green'}
                {'red'}
                {'yellow'}
                {'magenta'}
                {'cyan'}
                {'white'}
                {'neutral 8'}
                {'neutral 6.5'}
                {'neutral 5'}
                {'neutral 3.5'}
                {'black'}...
                ];

            BoundedDiv=8;
            Dx=ceil(max(abs(P(2,1)-P(1,1)),abs(P(2,2)-P(1,2))));
            Dy=Dx;

            P(:,1)=P(:,1)-Offset(1);
            P(:,2)=P(:,2)-Offset(2);


            P=ceil(P);



            R=SubImg(:,:,1);
            G=SubImg(:,:,2);
            B=SubImg(:,:,3);

            for i=1:length(P)
                %     I=R-mean(mean(SubImg(P(i,2)-3:P(i,2)+3,P(i,1)-3:P(i,1)+3,1)));
                %     I(:,:,2)=G-mean(mean(SubImg(P(i,2)-3:P(i,2)+3,P(i,1)-3:P(i,1)+3,2)));
                %     I(:,:,3)=B-mean(mean(SubImg(P(i,2)-3:P(i,2)+3,P(i,1)-3:P(i,1)+3,3)));
                %     I=sum(abs(I),3);
                %     Mean=mean(mean(I));
                %     Mask=(I<(Mean/5))*256;
                %     Mask(1:P(i,2)-Dy,:)=0;
                %     Mask(P(i,2)+Dy:end,:)=0;
                %     Mask(:,1:P(i,1)-Dx)=0;
                %     Mask(:,P(i,1)+Dy:end)=0;
                %
                % %     figure(7);image(Mask);colormap(gray);
                % %     pause
                %     CC = bwconncomp(Mask,4);
                %     STATS = regionprops(CC, {'Area','Centroid','BoundingBox'});
                %     Idx=1;
                %     Area=STATS(1).Area;
                %     for j=2:size(STATS,1)
                %         if STATS(j).Area>Area
                %             Area=STATS(j).Area;
                %             Idx=j;
                %         end
                %     end
                %
                %     %[Y1,X1]=ind2sub(size(Mask),CC.PixelIdxList{Idx});
                %
                %     Mask=Mask.*0;
                %     Mask(CC.PixelIdxList{Idx})=256;
                %     %figure(7);image(Mask);colormap(gray);
                %
                %     P(i,1:2)=P(i,1:2)+Offset(1:2);
                %
                %     Temp=STATS(Idx);
                %     Temp.Centroid=Temp.Centroid+Offset(1:2);
                %     Temp.R=mean(R(CC.PixelIdxList{Idx}));
                %     Temp.G=mean(G(CC.PixelIdxList{Idx}));
                %     Temp.B=mean(B(CC.PixelIdxList{Idx}));

                Temp.Area=Dx^2/2;
                Temp.BoundingBox=[];

                D=ceil(Dx/BoundedDiv);
                Size=size(SubImg);
                Temp.R=mean(mean(SubImg(max(1,P(i,2)-D):min(P(i,2)+D,Size(1)),max(1,P(i,1)-D):min(Size(2),P(i,1)+D),1)));
                Temp.G=mean(mean(SubImg(max(1,P(i,2)-D):min(P(i,2)+D,Size(1)),max(1,P(i,1)-D):min(Size(2),P(i,1)+D),2)));
                Temp.B=mean(mean(SubImg(max(1,P(i,2)-D):min(P(i,2)+D,Size(1)),max(1,P(i,1)-D):min(Size(2),P(i,1)+D),3)));

                P(i,1:2)=P(i,1:2)+Offset(1:2);
                Temp.Centroid=P(i,:);

                Temp.X=P(i,1);
                Temp.Y=P(i,2);
                Pc(i,:)=Temp.Centroid;
                Ps(i)=Temp;


            end
            Dist=sqrt(sum((Pc-P).^2,2));
            [Area]=[Ps.Area]';
            MeanArea=mean(Area);
            MeanDist=mean(Dist);
            if MeanDist> Dx/2
                Fidelity=Dist.*0;
            else
                %[(Dist<Dx/3),(Area>MeanArea*0.7 & Area < Dx^2)]
                Fidelity=(Dist<Dx/3)&(Area>MeanArea*0.7 & Area < Dx^2);
            end



            Dx=Dx/BoundedDiv;
            Dy=Dy/BoundedDiv;

            for i=1:length(Fidelity)
                Ps(i).Fidality=Fidelity(i);
                Ps(i).Name=ColorCIE1931Names(i);
                Ps(i).NmaeInd=i;
                Ps(i).BoundedBox=ceil([Ps(i).Centroid(1)-Dx,Ps(i).Centroid(2)-Dy,Ps(i).Centroid(1)+Dx,Ps(i).Centroid(2)+Dy]);
            end

            Po=Ps;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Find the NumDip Dip points in an image
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% after suming rows or culomns an assumptio
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% is made that the min distance between
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% leagl dips is given
        end
