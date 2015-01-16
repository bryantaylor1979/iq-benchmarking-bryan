function [PASS,new_struct] = findmacbeth_amazon(IMAGE)
% parameters
imagescale = 8;
printdebug = false;

% code
struct = findmacbeth(IMAGE,imagescale,printdebug,[]);
if isempty(struct)
    PASS = false;
    new_struct = [];
else
    PASS = true;
    new_struct = amazon2generic(struct,'method2');
end