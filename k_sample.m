function y = k_sample(J, p, m, r, k, x, priorcoords)

% Prior for k of the form we discussed. (can see log_k_density.m
% a_k: scalar parameter
% b_k, c_k: vector parameters, passed as cell inputs.
% l_k: length of b_k and c_k (for ease of unpacking the cells)

l = priorcoords{end};
c_k = priorcoords{end-1};
b_k = priorcoords{end-2};
a_k = priorcoords{end-3};

b_k = reshape(cell2mat(b_k), [l 1]);
c_k = reshape(cell2mat(c_k), [l 1]);

b_k = repmat(b_k, 1, J);
c_k = repmat(c_k, 1, J);

M = size(x);
M = M(1);
y = x
x(2,1)
y(x == Inf) = 0;
z = y;
z(y ~= 0) = 1;
N = sum(z);

a = a_k + N;

X1 = y .* repmat(r, M, 1);

b = [b_k;X1];

c = [c_k; repmat(m, M, 1)];

l = size(c);
l = l(1);

b = num2cell(b,1);
c = num2cell(c,1);


xx = -0.3:0.01:-0.1;

y = zeros([1 J])

for i = 1:J
    a_k = a(i);
    b_k = b(i);
    c_k = c(i);
    
    l_zero_prob = exp(log_integrate(1, @(k) log_k_density(k{1}, a_k, b_k, c_k, l, 1), -10:0.01:-0.01));
    g_zero_prob = exp(log_integrate(1, @(k) log_k_density(k{1}, a_k, b_k, c_k, l, 1), 0.01:0.01:10));
    
    l_or_r = general_discrete([l_zero_prob, g_zero_prob]);
    
    %plot(xx, exp(log_k_density(xx, a(i), b(i), c(i), l, 0)))
    
    points = [0.1:0.1:4];
    
    if l_or_r == 1
        logf = @(x) log_k_density(-x,a(i),b(i),c(i),l, 0);
        gradlogf = @(x) ((logf(x+0.0001) - logf(x))./0.0001);
        y(i) = -ars(logf, gradlogf, points);
    end
    if l_or_r == 2
        logf = @(x) log_k_density(x,a(i),b(i),c(i),l, 0);
        gradlogf = @(x) ((logf(x+0.0001) - logf(x))./0.0001);
        y(i) = ars(logf, gradlogf, points);
    end
end

end