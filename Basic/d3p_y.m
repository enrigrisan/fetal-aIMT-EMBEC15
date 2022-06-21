%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita in avanti 3D:  f = d3p_y(Matrix)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3p_y(Mat) 
[m n o] = size(Mat);
f = Mat(1:m,[2:n n],1:o) - Mat; 
