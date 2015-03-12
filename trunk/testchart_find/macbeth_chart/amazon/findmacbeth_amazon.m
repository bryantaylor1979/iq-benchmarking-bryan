function [PASS,new_struct,integrity] = findmacbeth_amazon(IMAGE)
% parameters
imagescale = 8;
printdebug = false;
integrity.nopatchesfound = NaN;
integrity.Fidality = NaN;

% code
struct = findmacbeth(IMAGE,imagescale,printdebug,[]);
x = size(struct,2);
accum = 0;
for i = 1:x
    accum = accum + struct(i).Fidality;
end

if isempty(struct)
    PASS = false;
    new_struct = [];
else
    PASS = true;
    integrity.nopatchesfound = size(struct,2);
    integrity.Fidality = accum;
    new_struct = amazon2generic(struct,'method3');
end