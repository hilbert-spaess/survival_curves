function y = p_sample(J, p, m, r, k, x, p_a, p_b)

% Beta conjugate prior parametrised by p_a and p_b.

a = p_a + sum(x ~= Inf);
b = p_b + sum(x == Inf);
y = betarnd(a,b);
end