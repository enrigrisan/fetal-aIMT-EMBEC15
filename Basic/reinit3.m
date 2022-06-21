% Procedura di reinizializzazione 3D

function f=reinit3(Mat,Mat0)

[m n o]=size(Mat); 
sg = sign(Mat0);
dx = d3x(Mat);
dy = d3y(Mat);
dz = d3z(Mat);
MG_e = sqrt(dx.^2+dy.^2+dz.^2) +eps;

f = sg - Adv3m(Mat,sg.*dx./MG_e,sg.*dy./MG_e,sg.*dz./MG_e);