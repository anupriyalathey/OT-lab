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