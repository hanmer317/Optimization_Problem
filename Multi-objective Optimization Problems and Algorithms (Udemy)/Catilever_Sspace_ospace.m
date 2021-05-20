% d in [0.01 , 0.05]
% l in [0.2 , 1]
clear
clc


figure
subplot(1,2,1)
title('Search space')
xlabel('d')
ylabel('l');
hold on

subplot(1,2,2)
title('Objective space')
xlabel('Weight')
ylabel('Deflection')
hold on

d = linspace(0.01 , 0.05, 20);
l = linspace(0.2 , 1, 20);

for i = 1 : length(d)
    for j = 1 : length(l)
        x = [d(i) , l(j) ]  ;
        [o ] = Cantilever(x);
        subplot(1,2,1)
        plot(x(1) , x(2) , '.k');
        subplot(1,2,2)
        plot(o(1) , o(2) , '*r');
    end
end