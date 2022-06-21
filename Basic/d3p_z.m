%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita in avanti 3D:  f = d3p_z(Matrix)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3p_z(Mat) 
[m n o] = size(Mat);
f = Mat(1:m,1:n,[2:o o]) - Mat; 
