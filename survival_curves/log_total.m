function y = log_total(x)
m = max(x);
m(m == -Inf) = [0];
y2 = x - m;
y = log(sum(exp(y2))) + m;
end