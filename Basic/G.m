%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Funzione:  f = G(Matrix)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = G(Mat) 
[m n] = size(Mat);
f = sqrt(Dx(Mat).^2+Dy(Mat).^2); 
