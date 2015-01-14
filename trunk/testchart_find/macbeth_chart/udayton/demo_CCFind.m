% I = double(imread('macbeth_cwf.jpg'));
I = double(imread('Mannaquin_6500_50lux.jpg'));
[X,C] = CCFind(imresize(I,1/3));
X = X*3;
if isempty(X)
    [X,C] = CCFind(I); 
end
visualizecc(I.^(1/2.2),X);