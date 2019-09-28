function y = log_likelihood(x, J, m, k, p, r)

z = x;
z(z == Inf) = 0;
z(z ~= 0) = 1;
M = sum(z)

noinf = x;

noinf(noinf == Inf) = 1;
r1 = (k-1).*sum(log(noinf));
r2 = k .* (m-1) .* sum(log(noinf));
noinf = noinf .^ k;
noinf(x == Inf) = 0;
r3 = (-m) .* (r.^k) .* sum(noinf)

hasinf = x;
hasinf(hasinf ~= Inf) = 0;
hasinf(hasinf == Inf) = 1;
r4 = sum(hasinf) .* log(1-p);

y = M.*log(k) + r1 + M.*(log(m) + (k.*log(r)) - gammaln(m))  + r2 + r3 + r4;
end