%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Differenza finita centrata:  f = Dy(Matrix)  %                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Dy(Mat) 
[m n] = size(Mat);
f = (Mat(1:m,[2:n n]) - Mat(1:m,[1 1:n-1]))./2; 
