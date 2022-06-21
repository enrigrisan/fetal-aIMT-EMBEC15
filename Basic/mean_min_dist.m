% Computes the mean of the min euclidean distances between two sets of points
% A and B (m*2 and n*2)

function dist = mean_min_dist(A,B)

D = pdist2(A,B,'euclidean');

[M1,ind_min] = min(D,[],2);
[M2,~] = min(D(:,ind_min),[],1);

dist = mean(min([M1,M2'],[],2));