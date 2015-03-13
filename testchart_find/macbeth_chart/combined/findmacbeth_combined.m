function [PASS,struct,integrity] = findmacbeth_combined(IMAGE)
%%
flat_scene_threshold = 100000;
disp('trying amazon method')
[PASS,struct,integrity] = findmacbeth_amazon(IMAGE);
if PASS == false
  disp('trying udayton method')
  [PASS,struct,integrity] = findmacbeth_udayton(IMAGE, ...
                    'flat_scene_threshold', flat_scene_threshold);  
end