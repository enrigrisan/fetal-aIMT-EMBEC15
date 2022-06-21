%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parte parabolica:  f = K3(Matrix)      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = K3(M) 
[m n o] = size(M);
%f = (dxx(M).*dy(M).^2-2.*dy(M).*dx(M).*dx(dy(M))+dyy(M).*dx(M).^2 )./((d3x(M).^2+d3y(M).^2+d3z(M).^2)+0.0001);
f=( (d3yy(M)+d3zz(M)).*d3x(M).^2+(d3xx(M)+d3zz(M)).*d3y(M).^2+(d3xx(M)+d3yy(M)).*d3z(M).^2 ...
-2.*d3x(M).*d3y(M).*d3x(d3y(M))-2.*d3x(M).*d3z(M).*d3x(d3z(M))-2.*d3y(M).*d3z(M).*d3y(d3z(M)) ) ...
./((d3x(M).^2+d3y(M).^2+d3z(M).^2)+eps).^(3/2);