%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita centrata 3D:  f = D3x(Matrix)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3x(Mat) 
[m n o] = size(Mat);
f = (Mat([2:m m],1:n,1:o) - Mat([1 1:m-1],1:n,1:o))./2; 
