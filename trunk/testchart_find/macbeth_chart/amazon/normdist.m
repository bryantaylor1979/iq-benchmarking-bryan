function InRange=normdist(A,B,Min,Max,DirX,DirY,MinArea)
    InRange=0;

    if A.Area>MinArea && B.Area>MinArea

        SignX=1;SignY=1;
        Scale=min(A.MinorAxisLength,B.MinorAxisLength);
        Dist=sqrt(sum((A.Centroid-B.Centroid).^2));
        if DirX~=0
            SignX=sign(A.Centroid(1)-B.Centroid(1))*DirX;
        end
        if DirY~=0
            SignY=sign(A.Centroid(2)-B.Centroid(2))*DirY;
        end

        if SignX<0 || SignY<0
            Dist=-Dist;
        end
        if Dist/Scale>Min && Dist/Scale<Max

            InRange=1;
        end
    end
end
