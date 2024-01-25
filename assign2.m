clc 
clear all

% Max z = 2x1 + x2
% s.t. x1 + 2x2 <= 10
%      x1 + x2  <= 6
%      x1 - 2x2 <= 1

% Phase 1: Input parameters
A = [1 2; 1 1; 1 -2];
B = [10; 6; 1];
C = [2 1];

% Phase 2: Plotting lines
P = max(B);
x1  = 0:1:P;
x21 = (B(1) - A(1,1).*x1)./A(1,2);
x22 = (B(2) - A(2,1).*x1)./A(2,2);
x23 = (B(3) - A(3,1).*x1)./A(3,2);

% .( used for component wise multiplication in matrix
% Default increment = 1

% Compare each entry in x21 such that negative values are substituted by 0
% semicolon at end doesnt show up in output

x21 = max(0,x21);
x22 = max(0,x22);
x23 = max(0,x23);

% red, blue, black
% everything sequence wise

plot(x1, x21, 'r', x1, x22, 'b', x1, x23, 'k')
title('x1 vs x2')
xlabel('Value of x1')
ylabel('Value of x2')
legend('x1+2x2=10', 'x1+x2=6', 'x1-2x2=1')

% Phase 3: Finding corner points with axes
% Output gives the indexes in x1, x21, x22, x23 where the values are 0
% More than 2 points occur since we fixed thw negative values to 0 previously

cx1 = find(x1==0);
c1 = find(x21==0);
c2 = find(x22==0);
c3 = find(x23==0);

% Transpose
Line1 = ([x1([c1 cx1]); x21([c1 cx1])])';
Line2 = ([x1([c2 cx1]); x22([c2 cx1])])';
Line3 = ([x1([c3 cx1]); x23([c3 cx1])])';

% 'Since want unique in row-wise sense
% [5 0 -> Different; [5 0 -> Same
%  0 5]               5 0]
% Corner Points

corpt = unique([Line1; Line2; Line3], 'rows')

% Phase 4: Intersecting points of each line

% Denotes Origin(0,0) in column form
pt = [0;0]
% size(A): 3x2; size(A,1): no. of rows; size(A,2): no. of columns
% no. of constraints
for i = 1:size(A,1)
    for j = i+1:size(A,1)
    A1=A([i,j], :)
    B1=B([i,j], :)
    x = inv(A1)*B1
    pt = [pt x]
    end
end

intersecting_pt = pt';

% Phase 5: All corner points
% Not all corner points are feasible'
all_corpt = unique([intersecting_pt; corpt], 'rows')



