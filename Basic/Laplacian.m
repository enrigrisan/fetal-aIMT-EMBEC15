%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   f = Laplacian(Matrix)              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Laplacian(Mat) 
[m n] = size(Mat);
f = Dxx(Mat)+Dyy(Mat); 
