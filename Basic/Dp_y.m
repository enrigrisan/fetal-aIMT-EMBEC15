 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %  Differenza finita all'avanti:  f = Dp_y(Matrix)  %               
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f =  Dp_y(Mat) 
[m n] = size(Mat);
f = Mat(1:m,[2:n n]) - Mat;
