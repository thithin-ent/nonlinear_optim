clc; clear; close all;

a = 1;
b = 3;
c = 2;
w = 1;
t = [0:0.001:1];
len = length(t);

y = @(x) exp(a*x.^2 + b*x +c) + w;
Y = y(t);

figure;
hold on;
% plot(t,Y)

Y_noise = y(t) + 5*(randn(1,len)-0.5);
plot(t,Y_noise)

%% 비선형 최적화 - 가우스 뉴턴
% a, b ,c 가 비선형 최적화를 통해 찾아야 하는 변수, X = [a, b, c]' 3*1의 백터
% e = (Y_noise - 최적화중인 함수) 이므로, J = [e의 a 미분, e의 b 미분, e의 c 미분 ]으로 1*3크기의 백터


X = [5 5 5]';
    
for i = 1:1000
    e = Y_noise - exp(X(1)*t.^2 + X(2)*t + X(3)); e = e'; % 에러함수 생성
    
    J = @(t) [ -t.^2.*exp(X(1)*t.^2 + X(2)*t + X(3))    % 자코비안 계산
    -t.*exp(X(1)*t.^2 + X(2)*t + X(3))
    -exp(X(1).*t.^2 + X(2)*t + X(3))];
    J = J(t);
    
    X = X - inv(J*J')*J*e;                              % X 업데이트
end

y_optim = @(x) exp(X(1)*x.^2 + X(2)*x +X(3)) + w;
y_optim = y_optim(t);
plot(t,y_optim,'LineWidth', 3)

%% 비선형 최적화 - Levenberg-Marquardt
X = [5 5 5]';
E = [0 0];
e = 0;
damping = 1;
for i = 1:1000
    
    e = Y_noise - exp(X(1)*t.^2 + X(2)*t + X(3)); e = e';   % 에러함수 생성
    
    E(1) = e'*e;                            % mu 값 업데이트
    if E(1) < E(2)                          % 최적화가 잘되면 mu 값을 낮춤
        damping = damping*0.5;
    elseif E(1) > E(2)                      % 최적화가 잘안되면 mu 값을 높힘
        damping = damping*2;
    end
    E(2) = E(1);
    
    J = @(x) [ -x.^2.*exp(X(1)*x.^2 + X(2)*x + X(3))        % 자코비안 계산
    -x.*exp(X(1)*x.^2 + X(2)*x + X(3))
    -exp(X(1).*x.^2 + X(2)*x + X(3))];
    J = J(t);
    
    X = X - inv(J*J' + damping*diag(diag(J*J')))*J*e;       % X 업데이트
end

y_optim1 = @(x) exp(X(1)*x.^2 + X(2)*x +X(3)) + w;
y_optim1 = y_optim1(t);
plot(t,y_optim1,'m','LineWidth', 3)


