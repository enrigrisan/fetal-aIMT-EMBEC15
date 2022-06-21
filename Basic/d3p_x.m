%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita in avanti 3D:  f = d3p_x(Matrix)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3p_x(Mat) 
[m n o] = size(Mat);
f = Mat([2:m m],1:n,1:o) - Mat; 
