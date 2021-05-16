% PSO_binary algorithm for optimization

clear all
close all
clc




% Define the details of the  objective function
nVar = 20 * 2;
ub = ones(1,nVar); % Vector
lb = zeros(1,nVar); 
%ub = [7,7];
%lb = [2,2];

fobj = @ObjectiveFunction;
%fobj = @OurTableDesignProblem;
% Define the PSO's parameters
noP = 30;
maxIter = 1000;
wMax = 0.9;
wMin = 0.2;
c1 = 2;
c2 = 2;
vMax = (ub - lb) .* 0.2; 
vMin  = -vMax;

% The PSO algorithm

% Step 1: Initilize the particles
for k = 1 : noP
    Swarm.Particles(k).X = round((ub-lb) .* rand(1,nVar) + lb); % round within the scope
    Swarm.Particles(k).V = zeros(1, nVar); 
    Swarm.Particles(k).PBEST.X = zeros(1,nVar); 
    Swarm.Particles(k).PBEST.O = inf; 
    
    Swarm.GBEST.X = zeros(1,nVar);
    Swarm.GBEST.O = inf;
end


% Main loop
for t = 1 : maxIter
    
    % Calcualte the objective value
    for k = 1 : noP
        currentX = Swarm.Particles(k).X;
        Swarm.Particles(k).O = fobj(currentX);
        
        % Update the PBEST
        if Swarm.Particles(k).O < Swarm.Particles(k).PBEST.O 
            Swarm.Particles(k).PBEST.X = currentX;
            Swarm.Particles(k).PBEST.O = Swarm.Particles(k).O;
        end
        
        % Update the GBEST
        if Swarm.Particles(k).O < Swarm.GBEST.O
            Swarm.GBEST.X = currentX;
            Swarm.GBEST.O = Swarm.Particles(k).O;
        end
    end
    
    % Update the X and V vectors 
    w = wMax - t .* ((wMax - wMin) / maxIter);
    
    for k = 1 : noP
        Swarm.Particles(k).V = w .* Swarm.Particles(k).V + c1 .* rand(1,nVar) .* (Swarm.Particles(k).PBEST.X - Swarm.Particles(k).X) ...
                                                                                     + c2 .* rand(1,nVar) .* (Swarm.GBEST.X - Swarm.Particles(k).X);
                                                                                 
        
        % Check velocities 
        index1 = find(Swarm.Particles(k).V > vMax);
        index2 = find(Swarm.Particles(k).V < vMin);
        
        Swarm.Particles(k).V(index1) = vMax(index1);
        Swarm.Particles(k).V(index2) = vMin(index2);
        
        Swarm.Particles(k).X = Swarm.Particles(k).X + Swarm.Particles(k).V;
        
        % Check positions 
        %index1 = find(Swarm.Particles(k).X > ub);
        %index2 = find(Swarm.Particles(k).X < lb);
        
        %Swarm.Particles(k).X(index1) = ub(index1);
        %Swarm.Particles(k).X(index2) = lb(index2);
        
        %sigmoid transfer function
        s = 1./(1+exp(Swarm.Particles(k).V))
        
        %Update the position of k_th particles
        for d = 1:nVar
            r = rand();
            if r < s(d)
                Swarm.Particles(k).X(d) = 1;
            else
                Swarm.Particles(k).X(d) = 0;
            end
        end
                
                
        
    end
    
    outmsg = ['Iteration# ', num2str(t) , ' Swarm.GBEST.O = ' , num2str(Swarm.GBEST.O)];
    disp(outmsg);
    
    cgCurve(t) = Swarm.GBEST.O;
end
 
semilogy(cgCurve);


%Objective function
function [ o ] = ObjectiveFunction ( x )
Discrete_set = [10 , 20 , 30 , 40];
D_x = zeros(1,10);

idx = 0;
for k = 1 : 2 :  length (x)  % 1 : 40
    idx = idx + 1;
    if           x(k) == 0 && x(k+1) == 0
        D_x(idx) = Discrete_set(1);
    elseif    x(k) == 0 && x(k+1) == 1
        D_x(idx) = Discrete_set(2);
    elseif    x(k) == 1 && x(k+1) == 0
        D_x(idx) = Discrete_set(3);
     elseif    x(k) == 1 && x(k+1) == 1
        D_x(idx) = Discrete_set(4);
    end
end
o = sum (x .^ 2);  % Sphere test function 

end
