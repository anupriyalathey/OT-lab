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
% semicolon at end doesn't show up in output

x21 = max(0,x21)
x22 = max(0,x22)
x23 = max(0,x23)

% red, blue, black
% everything sequence wise

plot(x1, x21, 'r', x1, x22, 'b', x1, x23, 'k')
title('x1 vs x2')
xlabel('Value of x1')
ylabel('Value of x2')
legend('x1+2x2=10', 'x1+x2=6', 'x1-2x2=1')