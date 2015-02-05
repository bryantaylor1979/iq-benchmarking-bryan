function [PASS,struct,integrity] = findmacbeth_combined(imagename)
%%
flat_scene_threshold = 100000;
[PASS,struct,integrity] = findmacbeth_amazon(imagename);
if PASS == false
  [PASS,struct,integrity] = findmacbeth_udayton(imagename, ...
                    'flat_scene_threshold', flat_scene_threshold);  
end