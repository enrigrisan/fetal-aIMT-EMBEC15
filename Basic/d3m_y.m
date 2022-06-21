%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita in avanti 3D:  f = d3m_y(Matrix)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3m_y(Mat) 
[m n o] = size(Mat);
f = Mat - Mat(1:m,[1 1:(n-1)],1:o); 
