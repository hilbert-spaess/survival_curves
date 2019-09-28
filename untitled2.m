% xx = 0:0.1:10
% a = 4
% b = 1
% c = 2
% 
% f = @(x) proposal_r_density(x, a,b,c);
% logf = @(x) log(f(x));
% gradlogf = @(x) ((logf(x+0.001) -logf(x))./0.001);
% 
% points = [0.9*((a/(b*c))^(1/c)), 1.1*((a/(b*c))^(1/c))];
% 
% a = [1 2; 3 4]
% a .* [2 2]
% 
% gampdf(0.0001, 0.064, 1./(0.064*1.7693))

% truncated_gamma(0.156,0.156*1.594,0.0026)

xx = 0:0.1:15;
a = 34.5
b = 37
c = 1
plot(xx, log_proposal_r_density(xx,34.5,37,1) - log_proposal_r_density(0.5*((a/(b*c))^(1/c)),a,b,c))