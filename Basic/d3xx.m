%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    f = D3xx(Matrix)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = d3xx(Mat) 
[m n o] = size(Mat);
f = Mat([2:m m],1:n,1:o) - 2.* Mat + Mat([1 1:m-1],1:n,1:o); 