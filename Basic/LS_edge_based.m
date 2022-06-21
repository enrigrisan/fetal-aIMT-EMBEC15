%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-- Level-Set Edge-Based Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function phi_out = LS_edge_based(I,phi,iter,rein_step,dt,exit,beta,e,b,n,show) 

phi_ini = phi;

g = 1./(1+(G(I)./beta));
% g = (phi<=0)+(phi>0).*g;
dxg = Dx(g);
dyg = Dy(g);

ii = 1;
area = zeros(1,ceil(iter/rein_step));
rel_area_change = zeros(1,ceil(iter/rein_step));
area(1) = sum(sum(phi<=0));
safe_steps = 3;

if show
    figure;
end

for i = 1:iter

    phi = phi + dt.*(e.*g.*KG(phi)-b*g.*G(phi)+n.*Adv(phi,dxg,dyg));
    % phi = phi + dt.*(e.*g.*KG(phi)-b*Ball(phi,g)+n.*Adv(phi,dxg,dyg));
    
    if (i==1) || (mod(i,rein_step)==0)
        ii = ii + 1;
        
        if show
            imagesc(I), colormap gray, axis image, hold on;
            contour(phi_ini,[0,0],'r');
            contour(phi,[0,0],'w');
%             quiver(-dyg,-dxg,'b');
            title(['Iteration #',num2str(i)]);
            drawnow;
%             pause(0.2);
        end
        
        area(ii) = sum(sum(phi<=0));
        rel_area_change(ii-1) = abs((area(ii)-area(ii-1))/area(ii-1));
        
        if show
            disp(['Rel Area Change: ',num2str(rel_area_change(ii-1))]);
        end
        
        if ii>=safe_steps
            if(rel_area_change(ii-safe_steps+1:ii-1)<=exit)==ones(1,safe_steps-1)
                break
            end
        end
        
        phi = bwdist(phi<=0)-bwdist(phi>0);
        
    end
    
end

if show
    imagesc(I), colormap gray, axis image, hold on;
    contour(phi_ini,[0,0],'r');
    contour(phi,[0,0],'y');
    title(['Exit at Iteration #',num2str(i)]);
    drawnow;
end

phi_out = phi;

