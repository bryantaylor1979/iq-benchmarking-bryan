function new_struct = amazon2generic(struct, method)
      if strcmpi(method,'method1') 
      	  new_struct = method1(struct);
      else
      	  new_struct = method2(struct);
      end
end
function new_struct = method1(struct)
    %% method based on center and separation. 
    cropfactor = 0.4;
    % find patch separation by averaging the top row
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
function new_struct = method2(struct)
    for i = 1:24
        new_struct.(['Patch',num2str(i)]).UL.X = struct(i).BoundedBox(1);
        new_struct.(['Patch',num2str(i)]).UL.Y = struct(i).BoundedBox(2);
        
        new_struct.(['Patch',num2str(i)]).LR.X = struct(i).BoundedBox(3);
        new_struct.(['Patch',num2str(i)]).LR.Y = struct(i).BoundedBox(4);
        
        WIDTH = struct(i).BoundedBox(3) - struct(i).BoundedBox(1);
        HEIGHT = struct(i).BoundedBox(3) - struct(i).BoundedBox(1);
        
        new_struct.(['Patch',num2str(i)]).UR.X = struct(i).BoundedBox(1)+WIDTH;
        new_struct.(['Patch',num2str(i)]).UR.Y = struct(i).BoundedBox(2);
        new_struct.(['Patch',num2str(i)]).LL.X = struct(i).BoundedBox(3)-WIDTH; 
        new_struct.(['Patch',num2str(i)]).LL.Y = struct(i).BoundedBox(4);
    end
end