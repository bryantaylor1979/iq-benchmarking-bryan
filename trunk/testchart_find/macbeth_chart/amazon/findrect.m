function [Corner,Macbeth,Flag]=findrect(Ans,Ans2,ColorIdx)
    %estimate using direct transform estimation

    x=[5+44*(0:5)];
    y=[5+43*(0:3)];
    [X,Y]=meshgrid(x+20,y+20);
    X=X';
    Y=Y';

    MacbethData=[X(:),Y(:)]; % Center X, Center Y
    MacbethData=[MacbethData;...
        0,0         % uper left
        268,0       % top right
        268,177     % butom right
        0,177       % butom left
        113,90      % center of two red points
        ];


    BasePoints=MacbethData(ColorIdx,1:2);
    InputPoints=[Ans(1).Centroid;Ans(2).Centroid;Ans(3).Centroid];
    Transform='affine'  ;
    if ~isempty(Ans2)
        BaseInd=[18,6,7,19];
        for i=1:4
            if Ans2(i,1) >0
                BasePoints=[BasePoints;MacbethData(BaseInd(i),1:2)];
                InputPoints=[InputPoints;Ans2(i,:)];
                Transform='projective';
            end
        end
        if Ans2(2,1)==0 && Ans2(4,1)==0 % meaning we do not have corners
            Transform='affine'  ;
        end

    end

    TFORM = cp2tform(InputPoints, BasePoints, Transform);
    [X, Y] = tforminv(TFORM, MacbethData(:,1), MacbethData(:,2));
    Corner(:,1)=X(25:28);
    Corner(:,2)=Y(25:28);
    Macbeth=[X,Y];
    T=abs(TFORM.tdata.T(1:2,1:2));
    MainAxRatio=max(max(T(1,1),T(2,2))^2,max(T(1,1),T(2,2)))/min(T(1,1),T(2,2));
    OrtAxRatio=max(max(T(1,2),T(2,1))^2,max(T(1,2),T(2,1)))/min(T(1,2),T(2,1));
    if min(T(1,1),T(2,2))/max(T(1,2),T(2,1)) > 10 % diagonal parameters are dominante
        Flag=MainAxRatio;
        %debug print
        %display(sprintf('in new condition new res = %f , old = %f /n',Flag,max(MainAxRatio,OrtAxRatio)));
    else
        Flag = max(MainAxRatio,OrtAxRatio);
    end
    Flag=Flag>10 ;% indicate that transform has susspicios parameters, may be wrong
    Corner(5,:)=Corner(1,:);
end
