 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %  Differenza finita all'indietro:  f = Dm_y(Matrix)  %               
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f =  Dm_y(Mat) 
[m n] = size(Mat);
f = Mat - Mat(1:m,[1 1:n-1]);
