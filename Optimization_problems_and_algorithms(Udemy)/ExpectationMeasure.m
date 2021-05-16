function [ o ] = ExpectationMeasure ( x )


i = 0.001;
H = 50;  % Number of sampled points
delta = 0.05; % Manufacturing error
dim = length(x);

o=-((1/((2*pi)^0.5))*exp(-0.5*((((x(1)-1.5)*(x(1)-1.5)+(x(2)-1.5)*(x(2)-1.5))/0.5).^1))...
    +(2/((2*pi)^0.5))*exp(-0.5*((((x(1)-0.5)*(x(1)-0.5)+(x(2)-0.5)*(x(2)-0.5))/i).^1)));

F = zeros(1,H);
for k = 1 : H
    % [-delta , delta]
    r = 2*delta*rand(1, dim) - delta;
      
    x_pertubed = x + r;
    F(k) = -((1/((2*pi)^0.5))*exp(-0.5*((((x_pertubed(1)-1.5)*(x_pertubed(1)-1.5)+(x_pertubed(2)-1.5)*(x_pertubed(2)-1.5))/0.5).^1))...
        +(2/((2*pi)^0.5))*exp(-0.5*((((x_pertubed(1)-0.5)*(x_pertubed(1)-0.5)+(x_pertubed(2)-0.5)*(x_pertubed(2)-0.5))/i).^1)));
end

Expected_objective = o + sum(F);
Expected_objective = Expected_objective / (H + 1);

o = Expected_objective;

end