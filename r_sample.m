function y = r_sample(J, p, m, r, k, x, r_m, r_r)

% Gamma prior with scale r_m and rate r_r. 
%
% NOTE that currently using an improper uniform prior.
% I think I need a better gamma prior on r.

M = size(x);
M = M(1);

z = x
x = x.^k
x(z == Inf) = 0;
y = x
y(z ~= Inf) = 1;

a = sum(y .* repmat(m.*k, M, 1));
b = sum(y .* (repmat(m, M, 1).*x));
c = k;
y = zeros(1,J);
for i = 1:J
    a(i)
    b(i)
    c(i) = c(i);
    plot(0:0.1:10, exp(log_proposal_r_density(0:1:100, a(i), b(i), c(i))))
    points = [0.9*((a(i)/(b(i)*c(i)))^(1/c(i))),((a(i)/(b(i)*c(i)))^(1/c(i))):0.1: 1.1*((a(i)/(b(i)*c(i)))^(1/c(i)))];
    z = log_proposal_r_density(points(1),a(i),b(i),c(i));
    logf = @(x) log_proposal_r_density(x,a(i),b(i),c(i)) - z;
    gradlogf = @(x) ((logf(x+0.0001) -logf(x))./0.0001);
    s = ars(logf, gradlogf, points);
    u = rand;
    % Using imporoper uniform prior
    %while u > gampdf(s, r_m, 1/r_r)/gampdf(r(i), r_m, 1/r_r)
    %   s = ars(logf, gradlogf, points);
    %   u = rand;
    %end
    y(i) = s;
end
end