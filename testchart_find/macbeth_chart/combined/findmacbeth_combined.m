function [PASS] = findmacbeth_combined(imagename)
%%
[PASS] = findmacbeth_amazon(imagename);
if PASS == false
  [PASS] = findmacbeth_udayton(imagename);  
end