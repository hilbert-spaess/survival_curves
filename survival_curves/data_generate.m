xx = 0:0.01:10
l = general_discrete([100 1 1])
points = [1 10]
a = 158
b = 36
f = @(x) m_density(x,a,b)
logf = @(x) log(f(x))
gradlogf = @(x) ((logf(x+0.001) -logf(x))./0.001)

ax1 = subplot(2,1,1)
plot(ax1,xx, f(xx))
%s = []
%for i = 1:1000
   %s = [s,ars(f, logf, gradlogf, points)]
%end

%ax1 = subplot(2,1,1)
% ax2 = subplot(2,1,2)
% histogram(ax2,s)
% plot(ax1,xx, f(xx))
% %disp(s/1000)

% generate_params_and_data(100,0.2,1,1,1,1,1,0.5)
