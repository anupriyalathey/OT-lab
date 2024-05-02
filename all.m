% simplex
clc
clear all
cost = [2 1 0 0 0 0];
a = [1 2 1 0 0; 1 1 0 1 0; 1 -1 0 0 1];
b = [10; 6; 2];
A = [a b];
Var = {'x1', 'x2', 's1', 's2', 's3', 'sol'}
bv = [3 4 5]; %pos of s1, s2, s3
zjcj = cost(bv)*A-cost;

% Display initial simplex table
simplex_table = [A; zjcj]
array2table(simplex_table, 'VariableNames', Var)
RUN=true;
while RUN
    if any(zjcj(1:end-1)<0) % check for negative value optamility condition
        fprintf('The current BFS is not optimal \n');
        zc = zjcj(1:end-1);
        [Enter_val, pvt_col] = min(zc); % array
        if all(A(:, pvt_col)<=0)
            error('LPP is unbounded');
        else
            sol = A(:, end);
            column = A(:,pvt_col);
            for i=1:size(A,1)
                if column(i)>0 % pivot column value positive
                ratio(i) = sol(i)./column(i);
                else
                    ratio(i) = inf;
                end
            end
            [leaving_value, pvt_row] = min(ratio);
        end
        bv(pvt_row) = pvt_col; % replaced leaving variable with entering variable
        pvt_key = A(pvt_row, pvt_col);
        A(pvt_row,:) = A(pvt_row,:)./pvt_key;

        % row operation
        for i = 1:size(A,1)
            if i~= pvt_row
                A(i,:) = A(i,:) - A(i,pvt_col).*A(pvt_row, :);
            end
        end
        zjcj = cost(bv)*A-cost;
        next_table=[zjcj; A];
        array2table(next_table, 'VariableNames', Var)

    else
        RUN = false;
        fprintf('The final optimal value is %f \n', zjcj(end));
    end
end



% -------------------------------



%lcs
clc
clear all

%% Phase1 : Input Data
cost=[11 20 7 8; 21 16 10 12; 8 12 18 9]
A=[50 40 70]
B=[30 25 35 40]

%% Phase 2: Check balanced/unbalanced
if (sum(A)==sum(B))
    fprintf('problem is balanced')
else
    fprintf('problem is unbalanced')

    if (sum(A)>sum(B))
        cost(:,end+1)=zeros(size(A,2),1)
        B(end+1)=sum(A)-sum(B)
        
    else
        cost(end+1,:)=zeros(1,size(B,2))
        A(end+1)=sum(B)-sum(A)
    end
end

icost=cost
x=zeros(size(cost))
m=size(cost,1)
n=size(cost,2)
bfs=m+n-1

%% Phase 3: Finding cells with minimum cost and allocations

for i=1:size(cost,1)
    for j=1:size(cost,2)
        hh=min(cost(:))
        [row_index,col_index]=find(hh==cost)
        x11=min(A(row_index),B(col_index))
        [value,index]=max(x11)
        ii=row_index(index)
        jj=col_index(index)
        y11=min(A(ii),B(jj))
        x(ii,jj)=y11
        A(ii)=A(ii)-y11
        B(jj)=B(jj)-y11
        cost(ii,jj)=inf
    end
end

%% Phase 4: Check degenerate /non-degenerate

total_bfs=length(nonzeros(x))
if total_bfs==bfs
    fprintf('initial bfs is non degenerate\n')
else
    fprintf('initial bfs is degenerate\n')
end

%%Phase 5: Compute the cost
initial_cost=sum(sum(icost.*x))
fprintf('initial cost is=%d\n',initial_cost)


%-----------------------------------

%steepest

clc 
clear all
format short
a=1
b=1/2
f=@(x,y)(x*x-x*y+y*y)
grad=@(x,y)[2*x-y,2*y-x]
for i=1:4   
    grad(a,b)
    d=-grad(a,b)/norm(grad(a,b))
    fun=@(z)((a+z*d(1))^2-(a+z*d(1))*(b+z*d(2))+(b+z*d(2))^2)
    x1=fminbnd(fun,0,10000)
    a=a+x1*d(1)
    b=b+x1*d(2)
end
fprintf('The optimal solution is %d\n', a,b)






%--------------------------
%simplex2
clc
clear
A=[3 -1  3  1  0  0;-2  4  0  0  1  0;-4  3  8  0  0  1]
B=[7;12;10]
C=[-1  3  -2  0  0  0]
index=[4,5,6]%mtlb filhal kisko BFS choose kia hua hai
m=length(B)%no of constraints
n=length(C)%no of variables
BS=[]%coefficient matrix of basic variables
CB=[]%this is the cost corresponding to basic variables
for i=1:m
    CB(i)=C(index(i))%this is cost corresponding to basic variables
    BS=[BS A(:,index(i))]%this is the coefficient matrix of basic variables
end
y=inv(BS)*A%this is table ki main values(sabhi aplha j ki values ek sath nikal li)
Xb=inv(BS)*B%right side of table
z=CB*y-C%this is zj-cj ka vector 
zmax=CB*Xb;

while(min(z)<0)%jab tak koi bhi ek value of zj-cj is less than 0 
 [min1,ev]=min(z);%ev will have index of entering variable
 ratio=[]
 for i=1:m
     if y(i,ev)>0
         ratio(i)=Xb(i)/y(i,ev)
     else
         ratio(i)=10^8;
     end

 end
 test=min(ratio)%choose minimum value from the ratio array
 if test==10^8
     fprintf('unbounded')
     return
 else
     [min1,LV]=min(ratio);%index of leaving variable is denoted by LV
     index(LV)=ev%ev ka index value according z(zj-cj) is written
 end
 BS=[]
 CB=[]
 for i=1:m
     CB(i)=C(index(i));
     BS=[BS A(:,index(i))]
 end
 y=inv(BS)*A
Xb=inv(BS)*B 
z=CB*y-C  
zmax=CB*Xb;
end
X=zeros
X(index)=Xb
zmax