ax1 = subplot(2,1,1)
ax2 = subplot(2,1,2)

a = [1]
b = [2]
c = [1]
i = 1
logf = @(x) log_proposal_r_density(x,a,b,c)
points = [0.9*((a(i)/(b(i)*c(i)))^(1/c(i))),((a(i)/(b(i)*c(i)))^(1/c(i))):0.01: 1.1*((a(i)/(b(i)*c(i)))^(1/c(i)))];
plot(ax1,0:0.1:10, exp(logf(0:0.1:10)))
gradlogf = @(x) ((logf(x+0.00001) -logf(x))./0.00001);
ys = [];
% points = [b/(5*a),b/(2*a), b/a]
points = [0.9*((a(i)/(b(i)*c(i)))^(1/c(i))),((a(i)/(b(i)*c(i)))^(1/c(i))):0.01: 1.1*((a(i)/(b(i)*c(i)))^(1/c(i)))]
z = ars(logf,gradlogf,points);
k = [];
for l = 1:10000
    z = ars(logf,gradlogf,points);
    if z < 1
        k = [k,1];
    else
        k = [k,0];
    end
    ys = [ys,z];
end

q = exp(log_integrate(1, @(x) logf(x{1}),0:0.01:1) - log_integrate(1,@(x) logf(x{1}),0:0.01:20))
z = mean(k)
histogram(ax2,ys)
