function f = KG(M) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  f = KG(Matrix)
%
% Calcola il prodotto tra la curvatura K ed il modulo del gradiente di M
%
% Parametri in ingresso:
% M   := matrice cui applicare la funzione
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 1 
    f = (Dxx(M).*(Dy(M).^2)-2.*Dy(M).*Dx(M).*(Dx(Dy(M)))+Dyy(M).*(Dx(M).^2))./(Dx(M).^2+Dy(M).^2+0.000001);  
else error(' Usage: f = KG(Matrix)');
end

