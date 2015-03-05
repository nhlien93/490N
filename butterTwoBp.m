function [ b, a ] = butterTwoBp( dt, fl, fu ) 
q=pi*dt*(fu-fl);
r=pi*dt*(fu+fl);
N = (tan(q)^2) + sqrt(2)*tan(q) + 1;
M = (tan(q)^2) / N; %M after N because it depends on N
O = -cos(r) * (2*sqrt(2)*tan(q) + 4) / ((cos(q))*N);
P = (-2*(tan(q)^2) + ((  (2*cos(r))   /  (cos(q))   )^2) + 2 )  /   N;
Q = cos(r)*(2*sqrt(2)*tan(q) - 4)/(cos(q)*N);
R = (   (tan(q)^2) - sqrt(2)*tan(q) + 1   )  /  N;

b=[M 0 -2*M 0 M];
a=[1 O P Q R];