function distances = euclidean_distances(X, Y, squared)
% Considering the rows of X (and Y) as vectors, compute the distance matrix
% between each pair of vectors.

if nargin<3
    squared = false;
end

n_samples_X = size(X,1);
n_samples_Y = size(Y,1);

norms_X = sum(X.^2,2);
norms_Y = sum(Y.^2,2);

dot_XX = repmat(norms_X,1,n_samples_Y);
dot_YY = repmat(norms_Y.',n_samples_X,1);

distances_squared = dot_XX + dot_YY - 2*X*Y.';

if squared
    distances = distances_squared;
else
    distances = sqrt(distances_squared);
end 
