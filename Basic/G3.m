%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Funzione:  f = G3d(Matrix)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = G3(Mat) 
[m n o] = size(Mat);
f = sqrt(d3x(Mat).^2+d3y(Mat).^2+d3z(Mat).^2); 
