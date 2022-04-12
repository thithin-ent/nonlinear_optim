clc; clear all; close all;
t = [0:0.1:5];
t1 = [5.1:0.1:10]; 
len = length(t);
len1 = length(t1);

a = 5*t + (randn(1,len)-0.5) + 2;
a1 = -5*t1 + (randn(1,len1)-0.5) + 54;

figure
hold on
plot(t,a,'*')
plot(t1,a1,'*')

A = [t', ones(len,1)];
[U,S,V] = svd(A);
S = S';
S(1,1) = 1/S(1,1); 
S(2,2) = 1/S(2,2); 

X = V*S*U'*a';

a = X(1)*t + X(2);

A1 = [t1', ones(len1,1)];
[U,S,V] = svd(A1);
S = S';
S(1,1) = 1/S(1,1); 
S(2,2) = 1/S(2,2); 

X1 = V*S*U'*a1';

a1 = X1(1)*t1 + X1(2);

plot(t,a)
plot(t1,a1)



