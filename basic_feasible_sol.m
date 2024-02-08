% Max z = 2x1 + 3x2 + 4x3 + 7x4
% subject to
% 2x1 + 3x2 - x3 + 4x4 = 8
% x1 + 2x2 + 6x3 -7x4 = -3
% x1, x2, x3, x4 >= 0

clc 
clear all
A = [2, 3, -1 4; 1, 2, 6, -7];
B = [8; -3];
C = [2, 3, 4, 7];

n = size(A,2)
m = size(A,1)

if n>m
nCm = nchoosek(n,m)
p = nchoosek(1:n, m)
sol = []
end
for i=1:nCm
    y = zeros(n,1)
    A1=A(:, p(i,:))
    X = inv(A1)*B
    
    % if in eq "=0" if all(X>0)
    if all(X>=0 & X~=inf & X~=-inf)
        y(p(i,:)) = X
        sol = [sol y]
    end
end
 
 Z = C*sol