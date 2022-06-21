 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %  Differenza finita all'indietro:  f = Dm_x(Matrix)  %               
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f =  Dm_x(Mat) 
[m n] = size(Mat);
f = Mat - Mat([1 1:m-1],1:n);
