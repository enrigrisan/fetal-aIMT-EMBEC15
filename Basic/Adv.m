%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parte advettiva:  f = Adv(I,Fx,Fy)     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Adv(I,Fx,Fy) 
f=((Fx>0).*Dp_x(I) +(Fx<0).*Dm_x(I)).*Fx +((Fy>0).*Dp_y(I) +(Fy<0).*Dm_y(I)).*Fy ;