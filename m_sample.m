function y = m_sample(J, p, m, r, k, x, m_a, m_b)

    % Conjugate prior for m of the form detailed in log_m_density.m
    
    M = size(x);
    M = M(1);
    y = x.^repmat(k,M,1)
    y(x == Inf) = 0;
    z = y;
    z(y ~= 0) = 1;
    N = sum(z);
    y(y == 0) = 1;
    X1 = sum(log(y));
    y(y==1) = 0;
    z2 = repmat(r.^k,M,1).*y;
    X2 = sum(z2);
    z3 = repmat(log(r).*k, M, 1);
    z3(y == 0) = 0;
    X3 = sum(z3);
    
    b = m_b + N;
    a = m_a + m_b - X1 + X2 - X3 -b;
    y = zeros(1,J);
    
    for i = 1:J
        a;
        b;
        points = [b(i)/(5*a(i)),b(i)/(2*a(i)), b(i)/a(i)];
        points;
        g = log_m_density(points(1), a(i), b(i));
        logf = @(x) log_m_density(x,a(i),b(i)) - g;
        plot(0:0.1:10, logf(0:0.1:10))
        gradlogf = @(x) ((logf(x+0.001) -logf(x))./0.001);
        plot(0:0.1:10, logf(0:0.1:10))
        y(i) = ars(logf, gradlogf, points);
    end
end