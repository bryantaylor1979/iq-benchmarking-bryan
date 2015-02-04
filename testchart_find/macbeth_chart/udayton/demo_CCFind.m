%I = double(imread('macbeth_cwf.jpg'));
I = double(imread('Blue_Sky_580LUX_8394K.jpg'));
[X,C] = CCFind(imresize(I,1/3));
X = X*3;
if isempty(X)
    [X,C] = CCFind(I); 
end
visualizecc(I.^(1/2.2),X);