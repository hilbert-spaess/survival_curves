function y = log_p_prior(p, a, b)
y = (a .* p) + (b .* (1-p));
end