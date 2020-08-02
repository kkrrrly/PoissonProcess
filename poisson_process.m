%% Constant Box
%Time  same unit as lambda (i.e hour)
    T = 4.26e8;
    t = 0:1:T;

%% Time dependent lambda function
lambda = zeros(1,T+1);
lambda(1,:) = 5e-7;

%% Step 1: Estimate the mean arrival rate throughout the interval T
lambda_mean = sum(lambda)/T;

%% Step 2: Using a constant rate #lambda_mean with inversion method,generate a sample value of N(T), say k, the number of Pssion event in T
T_sum = 0;
k =0;
rng('shuffle');
while T_sum < T
    r = rand;
    T_n = round(-log(r)/lambda_mean);
    T_sum = T_sum+T_n;
    k = k+1;    
end   

%% Step 3: Use rejection method, and the funcion #lambda to exactly k unorder time instants in [0,T];
tau = zeros(1,k);
j = 0;
while j < k
    c = max(lambda);
    r1 = rand*c;
    r2 = rand*T;
    if r1 < 5e-7*r2
        j = j+1;
        tau(1,j) = round(r2);
    end
end
clear lambda
%% Step 4: Rearrange (sort) the time instants #tau
tau = sort(tau);

%% Plot

y = zeros(1,T+1);
for i = 1:k
    y(1,tau(i)+1:end) = i;
end

plot (t,y,'-',...
    'LineWidth',2)
