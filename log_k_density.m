function y = log_k_density(k, a, b, c, l, sw)
if sw == 1
    k = k';
end
b = reshape(cell2mat(b), [l 1]);
c = reshape(cell2mat(c), [l 1]);

M = size(k);
M = M(2);


b = repmat(b, 1, M);
c = repmat(c, 1, M);

d = b;
d(b == 0) = 1;
dd = d.^k;
dd(dd == 1) = 0;

size(c);
size(k);

y = log(abs(k)).*a + sum((log(d).*(c.*k) - (c .* (dd))));
end