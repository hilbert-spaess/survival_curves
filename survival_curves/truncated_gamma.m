function y = truncated_gamma(m,r,a)
pd = makedist('Gamma','a',m,'b',1./r);
t = truncate(pd, a, Inf);
y = random(t);
end
