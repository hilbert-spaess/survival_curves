function y = adherence_sample(J, p, m, r, k, x, deaths, censored)
    M = size(x);
    M = M(1);
    ndeaths = deaths;
    ndeaths(deaths == Inf) = 0;
    weights = (p.* gampdf(repmat(ndeaths,1,J).^repmat(k, M, 1),repmat(m,M,1),repmat(1./(m.*(r.^k)),M,1))) ./ (1 - (p.*gamcdf(repmat(ndeaths,1,J).^repmat(k,M,1),repmat(m,M,1),repmat(1./(m.*(r.^k)),M,1))));
    adherences = zeros(M,1);
    for i = 1:M
        if censored(i) ~= 1
            adherences(i) = general_discrete(weights(i,:));
        end
    end
    adherences(deaths == Inf) = 0;
    y = adherences;
end

