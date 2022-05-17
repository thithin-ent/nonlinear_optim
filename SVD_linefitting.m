clc; clear all; close all;
t = [0:0.1:5];
t1 = [5.1:0.1:10]; 
len = length(t);
len1 = length(t1);

% a = 5*t + (randn(1,len)-0.5) + 2;
% a1 = -5*t1 + (randn(1,len1)-0.5) + 52.5;

a = 5*t + 2;
a1 = -5*t1 + 52.5;

%% 이동 데이터 생성
r = 3.14/4;
Tx = 2;
Ty = 2;
R = [cos(r); sin(r); Tx; Ty]; 


tb = cos(r)*t -sin(r)*a + Tx;
b = sin(r)*t + cos(r)*a + Ty;

tb1 = cos(r)*t1 -sin(r)*a1 + Tx;
b1 = sin(r)*t1 + cos(r)*a1 + Ty;

a = a + (randn(1,len)-0.5);
a1 = a1 + (randn(1,len1)-0.5);

tb = tb + 0.25*(randn(1,len)-0.5);
tb1 = tb1 + 0.25*(randn(1,len1)-0.5);
b = b + 0.25*(randn(1,len)-0.5);
b1 = b1 + 0.25*(randn(1,len1)-0.5);

%% 라인 피팅
A = [t', ones(len,1)];
[U,S,V] = svd(A);
S = S';
S(1,1) = 1/S(1,1); 
S(2,2) = 1/S(2,2); 
X = V*S*U'*a';
aa = X(1)*t + X(2);

A1 = [t1', ones(len1,1)];
[U,S,V] = svd(A1);
S = S';
S(1,1) = 1/S(1,1); 
S(2,2) = 1/S(2,2); 
X1 = V*S*U'*a1';
aa1 = X1(1)*t1 + X1(2);

B = [tb', ones(len,1)];
[U,S,V] = svd(B);
S = S';
S(1,1) = 1/S(1,1); 
S(2,2) = 1/S(2,2); 
Y = V*S*U'*b';
bb = Y(1)*tb + Y(2);

B1 = [tb1', ones(len1,1)];
[U,S,V] = svd(B1);
S = S';
S(1,1) = 1/S(1,1); 
S(2,2) = 1/S(2,2); 
Y1 = V*S*U'*b1';
bb1 = Y1(1)*tb1 + Y1(2);

figure(1)
axis equal
hold on
plot(t,a,'*')
plot(t1,a1,'*')
plot(t,aa)
plot(t1,aa1)

First_dot = inv([-X(1),1;-X1(1),1])*[X(2);X1(2)];
% plot(First_dot(1),First_dot(2),'.','MarkerSize',25)
First_dot1 = First_dot + 10*normc([-1; -X(1)]);
First_dot2 = First_dot + 10*normc([1; X1(1)]);
First_dot3 = First_dot + 5*normc([-1; -X(1)]);
First_dot4 = First_dot + 5*normc([1; X1(1)]);
% plot(First_dot1(1),First_dot1(2),'.','MarkerSize',25)
% plot(First_dot2(1),First_dot2(2),'.','MarkerSize',25)
% plot(First_dot3(1),First_dot3(2),'.','MarkerSize',25)
% plot(First_dot4(1),First_dot4(2),'.','MarkerSize',25)
First_dot = [First_dot First_dot1 First_dot2 First_dot3 First_dot4];


figure(2)
axis equal
hold on
plot(tb,b,'*')
plot(tb1,b1,'*')
plot(tb,bb)
plot(tb1,bb1)

second_dot = inv([-Y(1),1;-Y1(1),1])*[Y(2);Y1(2)];
% plot(second_dot(1),second_dot(2),'.','MarkerSize',25)
second_dot1 = second_dot + 10*normc([1; Y(1)]);
second_dot2 = second_dot + 10*normc([1; Y1(1)]);
second_dot3 = second_dot + 5*normc([1; Y(1)]);
second_dot4 = second_dot + 5*normc([1; Y1(1)]);
% plot(second_dot1(1),second_dot1(2),'.','MarkerSize',25)
% plot(second_dot2(1),second_dot2(2),'.','MarkerSize',25)
% plot(second_dot3(1),second_dot3(2),'.','MarkerSize',25)
% plot(second_dot4(1),second_dot4(2),'.','MarkerSize',25)
second_dot = [second_dot; second_dot1; second_dot2; second_dot3; second_dot4];

%% 
% 
% A_t = [First_dot(1,1) -First_dot(2,1) 1 0;
%     First_dot(2,1) First_dot(1,1) 0 1;
%     First_dot(1,2) -First_dot(2,2) 1 0;
%     First_dot(2,2) First_dot(1,2) 0 1;
%     First_dot(1,3) -First_dot(2,3) 1 0;
%     First_dot(2,3) First_dot(1,3) 0 1;];
% 
% RT = pinv(A_t)*second_dot(1:6)
% 
% tb = RT(1)*t + -RT(2)*a + RT(3);
% b = RT(2)*t + RT(1)*a + RT(4);
% 
% tb1 = RT(1)*t1 + -RT(2)*a1 + RT(3);
% b1 = RT(2)*t1 + RT(1)*a1 + RT(4);
% 
% figure(3)
% axis equal
% hold on
% plot(tb,b,'*')
% plot(tb1,b1,'*')

%% 


A_t = [First_dot(1,1) -First_dot(2,1) 1 0;
    First_dot(2,1) First_dot(1,1) 0 1;
    First_dot(1,2) -First_dot(2,2) 1 0;
    First_dot(2,2) First_dot(1,2) 0 1;
    First_dot(1,3) -First_dot(2,3) 1 0;
    First_dot(2,3) First_dot(1,3) 0 1;
    First_dot(1,4) -First_dot(2,4) 1 0;
    First_dot(2,4) First_dot(1,4) 0 1;
    First_dot(1,5) -First_dot(2,5) 1 0;
    First_dot(2,5) First_dot(1,5) 0 1;];

R
RT = pinv(A_t)*second_dot

tbb = RT(1)*t + -RT(2)*a + RT(3);
bb = RT(2)*t + RT(1)*a + RT(4);

tbb1 = RT(1)*t1 + -RT(2)*a1 + RT(3);
bb1 = RT(2)*t1 + RT(1)*a1 + RT(4);

figure(3)
axis equal
hold on
plot(tbb,bb,'r*')
plot(tbb1,bb1,'r*')
plot(tb,b,'b*')
plot(tb1,b1,'b*')