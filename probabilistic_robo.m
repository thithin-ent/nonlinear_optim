clc; clear; close all;
X_particle = [];
X = [0; 0; 0;];
Co = [0.01 0 0;0 0.01 0; 0 0 100];
S = 0.5;

for k = 1:1000
    X_particle(k,:) = [normrnd(X(1),Co(1,1)),normrnd(X(2),Co(2,2)),normrnd(X(3),Co(3,3))];
end
len = length(X_particle);

X1 = [0; 0; 0];
X1(1) = X(1) + cos(X(3));
X1(2) = X(2) + sin(X(3));
X1(3) = X(3);

figure
hold on
plot(X_particle(:,1),X_particle(:,2),'o')

Z = [1;0];
px = [];
py = [];
w = [];
ww = [];
X_nparticle = [];
for i = 1:len
    temp1 = X_particle(i,1) + cos(X_particle(i,3));
    temp2 = X_particle(i,2) + sin(X_particle(i,3));
    temp3 = X_particle(i,3);
    px(i) = normpdf(temp1,Z(1),S);
    py(i) = normpdf(temp2,Z(2),S);
    w(i) = px(i)*py(i);
    if(i == 1)
        ww(i) = w(i);
    else 
        ww(i) = ww(i-1) + w(i);
    end
    X_nparticle(i,:) = [temp1,temp2,temp3];
end


plot(X_nparticle(:,1),X_nparticle(:,2),'*')




X_reparticle = [];
rew = 0;
for i = 1:len
    temp = ww(len)*rand(1);
    for j = 1:len-1
        if ((temp > ww(j)) && (temp < ww(j+1)))
            X_reparticle(i,:) = X_nparticle(j+1,:);
            rew(i) = w(j+1);
        end
    end
end

plot(X_reparticle(:,1),X_reparticle(:,2),'go')

plot(Z(1)+1,Z(2),'s','MarkerSize',15,'MarkerFaceColor',[0.5,0.5,0.5])
plot(1,0,'p','MarkerSize',15,'MarkerFaceColor',[0.5,0.5,0.5])




