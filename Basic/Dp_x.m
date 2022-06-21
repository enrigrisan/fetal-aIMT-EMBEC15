 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %  Differenza finita all'avanti:  f = Dp_x(Matrix)  %               
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f =  Dp_x(Mat) 
[m n] = size(Mat);
f = Mat([2:m m],1:n) - Mat;
