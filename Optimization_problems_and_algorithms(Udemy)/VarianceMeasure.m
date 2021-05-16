function [ o ] = VarianceMeasure ( x )


i = 0.001;
H = 50;  % Number of sampled points 
delta = 0.05; % Manufacturing error
dim = length(x);
threshold = 0.01;

o=-((1/((2*pi)^0.5))*exp(-0.5*((((x(1)-1.5)*(x(1)-1.5)+(x(2)-1.5)*(x(2)-1.5))/0.5).^1))...
    +(2/((2*pi)^0.5))*exp(-0.5*((((x(1)-0.5)*(x(1)-0.5)+(x(2)-0.5)*(x(2)-0.5))/i).^1)));


F = zeros(1,H);
for idx = 1 : H;
    % [-delta , delta]
    r = 2*delta*rand(1, dim) - delta;
    x_pertubed = x + r;
    F(idx) = -((1/((2*pi)^0.5))*exp(-0.5*((((x_pertubed(1)-1.5)*(x_pertubed(1)-1.5)+(x_pertubed(2)-1.5)*(x_pertubed(2)-1.5))/0.5).^1))...
                     +(2/((2*pi)^0.5))*exp(-0.5*((((x_pertubed(1)-0.5)*(x_pertubed(1)-0.5)+(x_pertubed(2)-0.5)*(x_pertubed(2)-0.5))/i).^1)));
end

f = o;
F = mean(F);
var = abs(F-f) / f;
var = abs(var);


if var < threshold 
    o = f;
else
    o = 200;
end
 
end