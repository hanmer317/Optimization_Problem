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

% Apply the constraints 
Sy = 300e3;
delta_max = 0.005;

g(1) = -Sy + (32 * p * l) / (pi * d^3);  %-S_y + (23 * p * l) / (pi * d^3) <= 0
g(2) =  -delta_max + (64 * p * l^3) / (3*E*pi*d^4);  % <=0

if any(g > 0)
    o = [inf , inf]; % penalize the solution x with very large objective values
    o = [f1,f2];
    feasible = 0;
else
    o = [f1,f2];
     feasible = 1;
end


end