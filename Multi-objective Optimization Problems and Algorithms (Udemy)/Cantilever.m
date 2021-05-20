% define the cantilever beam optimization
function [ o , feasible ] = Cantilever (x) 

% d in [0.01 , 0.05]
% l in [0.2 , 1]

d = x(1);
l = x(2);

p = 1;
rho = 7800;
E = 207e6;

f1 = (rho * pi * d^2 * l) / 4;
f2 = (64 * p * l^3) / (3*E*pi*d^4);


o = [f1,f2];


end