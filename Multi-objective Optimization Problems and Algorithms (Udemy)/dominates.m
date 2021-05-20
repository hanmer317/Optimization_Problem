function [ o ] = dominates( x , y )

o = all (x<=y) && any(x<y);

% L = length(x);
% lessThanOrEqualTo = zeros(1, L);
% lessThan = zeros(1,L); 
% 
% for i = 1 : L
%     if x(i) <= y(i)  % first condition of Pareto optiamlity 
%         lessThanOrEqualTo(i) = 1;
%     else
%         lessThanOrEqualTo(i) = 0;
%     end
%     
%     if x(i) < y(i) % second condition fo Pareto optimality 
%         lessThan(i) = 1;
%     else
%        lessThan(i) = 0;
%     end
% end
% 
% if sum(lessThanOrEqualTo) == L && sum(lessThan) >= 1
%     o =1;
% else
%     o = 0;
% end
end