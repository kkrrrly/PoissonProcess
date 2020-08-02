%% Constant Box
%Time  same unit as lambda (i.e hour)
    T = 4.26e8;
    t = 0:1:T;
    count_x = 1:1:300;
    count_y = zeros(1,300);


%% Time dependent lambda function
lambda = zeros(1,T+1);
lambda(1,:) = 5e-7;

%% Step 1: Estimate the mean arrival rate throughout the interval T
lambda_mean = sum(lambda)/T;

%% Step 2: Using a constant rate #lambda_mean with inversion method,generate a sample value of N(T), say k, the number of Pssion event in T



for i = 1:1000
    rng('shuffle');
    T_sum = 0;
    k =0;
    while T_sum < T
        r = rand;
        T_n = round(-log(r)/lambda_mean);
        T_sum = T_sum+T_n;
        k = k+1;    
    end
    p = count_y(1,k);
    count_y(1,k) = p+1;
end
bar(count_x,count_y);
clear t lambda;
xlim([150,300]);

%%data analysis

count_y1 = zeros(1,30);
count_x1 = 10:10:300;
for i = 1:30
    count_y1(i) = sum(count_y(1,(i-1)*10+1:i*10));
end
figure();
bar(count_x1,count_y1);
xlim([150,300]);
xlabel('Number of FBO event');
ylabel('Number of occurrences in 1000 repeated experiments');
