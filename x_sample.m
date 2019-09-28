function y = x_sample(J, p, m, r, k, x, deaths, adherences, censored)
    M = size(x);
    M = M(1);
    q = zeros(size(x))
    % removed + np.*gamcdf(deaths(i).^nk, nm, 1./(nm.*(nr.^nk)))
    for j = 1:J
        nm = m(j); nr = r(j); nk = k(j); np = p(j);
        for i = 1:M
            if or(deaths(i) == Inf, general_discrete([np*gamcdf(deaths(i).^nk, nm,1./(nm.*(nr.^nk)), 'upper'), 1 - np]) == 2)
                q(i,j) = Inf;
            else
                q(i,j) = (truncated_gamma(nm,nm*(nr^nk),deaths(i).^nk)).^(1./nk);
            end      
        end
    end
    for i = 1:M
        if and(censored(i) ~= 1, adherences(i) ~= 0)
            q(i,adherences(i)) = deaths(i);
        end
    end
    y = q
end