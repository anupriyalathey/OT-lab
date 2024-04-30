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