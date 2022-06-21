%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita centrata:  f = Dx(Matrix)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Dx(Mat) 
[m n] = size(Mat);
f = (Mat([2:m m],1:n) - Mat([1 1:m-1],1:n))./2; 
