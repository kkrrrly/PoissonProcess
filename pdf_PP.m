lambda = 5e-7;
t = 3e7;
times = 5;%次数
z = zeros(times+1,t+1);
for i = 0:100
    z(:,i+1) = poisspdf(0:1:times,i*lambda);
end
mesh(0:1:t,0:1:times,z);