%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita centrata 3D:  f = D3y(Matrix)  %                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3y(Mat) 
[m n o] = size(Mat);
f = (Mat(1:m,[2:n n],1:o) - Mat(1:m,[1 1:n-1],1:o))./2; 
