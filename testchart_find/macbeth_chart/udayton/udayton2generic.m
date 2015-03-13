function new_struct = udayton2generic(rois)
    new_struct = method2(rois);
end
function new_struct = method1(rois)
    %% method based on center and separation. 
    cropfactor = 0.4;
    % find patch separation by averaging the top row
    for i = 1:24
        struct(i).X = rois(i,2);
        struct(i).Y = rois(i,1);
    end
    PatchSeparation = round(mean(diff([struct(1).X,struct(2).X,struct(3).X,struct(4).X,struct(5).X,struct(6).X])));
    boxsize = PatchSeparation*cropfactor;
    for i = 1:24
        new_struct.(['Patch',num2str(i)]).LL.X = struct(i).X-floor(boxsize/2);
        new_struct.(['Patch',num2str(i)]).LL.Y = struct(i).Y+floor(boxsize/2);
        new_struct.(['Patch',num2str(i)]).UL.X = struct(i).X-floor(boxsize/2);
        new_struct.(['Patch',num2str(i)]).UL.Y = struct(i).Y-floor(boxsize/2);
        new_struct.(['Patch',num2str(i)]).LR.X = struct(i).X+floor(boxsize/2);
        new_struct.(['Patch',num2str(i)]).LR.Y = struct(i).Y+floor(boxsize/2); 
        new_struct.(['Patch',num2str(i)]).UR.X = struct(i).X+floor(boxsize/2);
        new_struct.(['Patch',num2str(i)]).UR.Y = struct(i).Y-floor(boxsize/2);
    end
end
function new_struct = method2(rois)
    %% method based on center and separation. 
    cropfactor = 0.4;
    % find patch separation by averaging the top row
    for i = 1:24
        struct(i).X = rois(i,2);
        struct(i).Y = rois(i,1);
    end
    PatchSeparation = round(mean(diff([struct(1).X,struct(2).X,struct(3).X,struct(4).X,struct(5).X,struct(6).X])));
    boxsize = PatchSeparation*cropfactor;
    for i = 1:24
        new_struct{i}{1} = [struct(i).X-floor(boxsize/2), struct(i).Y-floor(boxsize/2)];
        new_struct{i}{2} = [struct(i).X+floor(boxsize/2), struct(i).Y-floor(boxsize/2)];
        new_struct{i}{3} = [struct(i).X+floor(boxsize/2), struct(i).Y+floor(boxsize/2)];
        new_struct{i}{4} = [struct(i).X-floor(boxsize/2), struct(i).Y+floor(boxsize/2)];
    end
end