%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parte advettiva:  f = Ball3(I,F)     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Ball3(I,F) 

Dp_x = d3p_x(I);
Dm_x = d3m_x(I);
Dp_y = d3p_y(I);
Dm_y = d3m_y(I);
Dp_z = d3p_z(I);
Dm_z = d3m_z(I);

gradp = sqrt((Dm_x>0).*(Dm_x.^2)+(Dp_x<0).*(Dp_x.^2)+...
            +(Dm_y>0).*(Dm_y.^2)+(Dp_y<0).*(Dp_y.^2)+...
            +(Dm_z>0).*(Dm_z.^2)+(Dp_z<0).*(Dp_z.^2));
        
gradm = sqrt((Dp_x>0).*(Dp_x.^2)+(Dm_x<0).*(Dm_x.^2)+...
            +(Dp_y>0).*(Dp_y.^2)+(Dm_y<0).*(Dm_y.^2)+...
            +(Dp_z>0).*(Dp_z.^2)+(Dm_z<0).*(Dm_z.^2));
        
f = F.*((F>0).*gradp +(F<0).*gradm);