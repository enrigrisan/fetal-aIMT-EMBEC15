%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    f = Dyy(Matrix)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Dyy(Mat) 
[m n] = size(Mat);
f = Mat(1:m,[2:n n]) - 2.*Mat + Mat(1:m,[1 1:n-1]);
