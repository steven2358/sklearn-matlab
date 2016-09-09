function n2 = dist2(x, c)
% DIST2 Calculates squared distance between two sets of points.
%
% Description D = DIST2(X, C) takes two matrices of vectors and calculates
% the squared Euclidean distance between them. Both matrices must be of the
% same column dimension. If X has M rows and N columns, and C has L rows
% and N columns, then the result has M rows and L columns. The I, Jth entry
% is the squared distance from the Ith row of X to the Jth row of C.

[ndata, dimx] = size(x);
[ncentres, dimc] = size(c);
if dimx ~= dimc
    error('Data dimension does not match dimension of centres')
end

n2 = repmat(sum(x.^2,2),1,ncentres) + ...
    repmat(transpose(sum(c.^2,2)),ndata,1) - ...
    2.*(x*transpose(c));
