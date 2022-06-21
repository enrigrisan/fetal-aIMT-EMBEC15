%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    f = D3yy(Matrix)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3yy(Mat) 
[m n o] = size(Mat);
f = Mat(1:m,[2:n n],1:o) - 2.*Mat + Mat(1:m,[1 1:n-1],1:o);