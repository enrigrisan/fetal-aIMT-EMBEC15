%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parte advettiva:  f = Adv3(I,Fx,Fy,Fz)     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Adv3(I,Fx,Fy,Fz) 
f=((Fx>0).*d3p_x(I) +(Fx<0).*d3m_x(I)).*Fx... 
 +((Fy>0).*d3p_y(I) +(Fy<0).*d3m_y(I)).*Fy...
 +((Fz>0).*d3p_z(I) +(Fz<0).*d3m_z(I)).*Fz;