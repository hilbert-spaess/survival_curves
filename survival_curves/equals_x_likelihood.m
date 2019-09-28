function y = equals_x_likelihood(J, p, k, m, r, deaths)

noinf = repmat(deaths, 1, J);
noinf1 = noinf .^ ((m.*k)-1);
noinf2 = noinf .^ k;
noinf1(noinf == Inf) = 0;
noinf2(noinf == Inf) = 0;

noinf = (p .* k .* (m .* (r.^k)) ./ gamma(m)) .* noinf1 .* exp(-m .* (r.^k) .* noinf2);

hasinf = repmat(deaths, 1, J)
hasinf(hasinf ~= Inf) = 0;
hasinf(hasinf == Inf) = 1;
hasinf = hasinf .* log(1-p);

y = noinf + hasinf;
end