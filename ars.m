function y = ars(logf, gradlogf, points)
i = 0;
while true
    vals = logf(points);
    grads = gradlogf(points);
    bounds = [0,((vals(2:end)-vals(1:end-1) + (grads(1:end-1).*points(1:end-1)) - (grads(2:end).*points(2:end)))./(grads(1:end-1) - grads(2:end)))];
    p = piecewise_exponential(points, vals, grads, bounds);
    k = p(1);
    u = rand;
    z1 = logf(k);
    z2 = grads(p(2));
    z3 = points(p(2));
    
    
    logf(k);
    grads(p(2))*(k-points(p(2)));
    vals(p(2));
    
    l = exp(logf(k) - (grads(p(2))*(k-points(p(2))))-vals(p(2)));
    if u < l
        break
    end
    points = [points,k];
    points = sort(points);
    i = i+1;
    m = max(vals);
    if not(isnan(m))
        nlogf = @(x) logf(x) - m;
        logf = nlogf;
    end
end
y = k;
end