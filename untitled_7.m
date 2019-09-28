% true_m
% median(ms)
% p
% true_p
% plot(ax1, 2:1:101,ms(2:end,1))
% plot(ax2, 2:1:101,ms(2:end,2))
% plot(ax3, 2:1:101,ms(2:end,3))

y = generate_params_and_data(N,0.2,1,1,1,1,1,0.5, [0], [0], [0], [0], [0], [0]);

ax1 = subplot(3,1,3)
ax2 = subplot(3,2,3)
true_J = 3
N = 100
p
r
m
true_k
y = generate_params_and_data(N,0.2,1,1,1,1,1,0.5, 0, [1,true_J], [1,p], [1,r], [1,m], [1,true_k]);
x = y{end-1}
ndeaths = y{end}
size(x)
size(ndeaths)
size(deaths)
%plot_survival_curve(ax1,deaths,N)
%plot_survival_curve(ax2, ndeaths, N)