%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita centrata 3D:  f = D3z(Matrix)  %                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3z(Mat) 
[m n o] = size(Mat);
f = (Mat(1:m,1:n,[2:o o]) - Mat(1:m,1:n,[1 1:o-1]))./2; 
