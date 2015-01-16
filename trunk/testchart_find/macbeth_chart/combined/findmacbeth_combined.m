function [PASS,struct] = findmacbeth_combined(imagename)
%%
[PASS,struct] = findmacbeth_amazon(imagename);
if PASS == false
  [PASS,struct] = findmacbeth_udayton(imagename);  
end