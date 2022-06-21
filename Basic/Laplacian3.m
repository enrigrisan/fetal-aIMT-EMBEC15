%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   f = Laplacian3d(Matrix)              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = laplacian3d(Mat) 
[m n o] = size(Mat);
f = d3xx(Mat)+d3yy(Mat)+d3zz(Mat); 
