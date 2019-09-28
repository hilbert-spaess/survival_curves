function y = k_prior_sample(J, k_a, k_b, k_c, l)

k_b = reshape(cell2mat(k_b), [l 1])
k_c = reshape(cell2mat(k_c), [l 1])

k_b = repmat(k_b, 1, J)
k_c = repmat(k_c, 1, J)

a = repmat(k_a, 1, J)
b = num2cell(k_b,1);
c = num2cell(k_c,1);

for i = 1:J
    k_a = a(i);
    k_b = b(i)
    k_c = c(i)
    
    l_zero_prob = exp(log_integrate(1, @(k) log_k_density(k{1}, k_a, k_b, k_c, l, 1), -10:0.01:-0.01))
    g_zero_prob = exp(log_integrate(1, @(k) log_k_density(k{1}, k_a, k_b, k_c, l, 1), 0.01:0.01:10))
    
    l_or_r = general_discrete([l_zero_prob, g_zero_prob])
    
    points = [0.1:0.1:4]
    
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