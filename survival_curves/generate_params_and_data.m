function y = generate_params_and_data(N, priorcoords, lost_rate, j_sam, p_sam, m_sam, r_sam, k_sam)

% the v_sam variables specifiy whether to sample variable v.
% If the first element of the cell is 0, the variable will be sampled as
% normal.
% If it is 1, then the second element of the cell is used.
% Note that currently I am fixing the k vector to 1, as I haven't got round
% to finding a good prior.

[maxJ, a_J, a_p, b_p, a_m, b_m, a_r, b_r, a_k, b_k, c_k, l_k] = priorcoords{:}

if not(j_sam{1})
    J = maxJ + 1
    while J > maxJ
        J = geornd(a_J)+1;
    end
else
    J = j_sam{2};
end

if not(p_sam{1})
    p = betarnd(a_p, b_p, [1 J]);
else
    p = p_sam{2}
end

if not(r_sam{1})
    r = gamrnd(a_r,b_r, [1 J]);
else
    r = r_sam{2}
end

if not(m_sam{1})

    logf = @(x) log_m_density(x,a_m,b_m);
    gradlogf = @(x) ((logf(x+0.0001) -logf(x))./0.0001);
    m = [];
    points = [b_m/(2*a_m), b_m/a_m];
    for i = 1:J
        m = [m,ars(logf, gradlogf,points)];
    end
else
    m = m_sam{2};
end

if not(k_sam{1})
    %k = k_prior_sample(J, a_k, b_k, c_k, l_k);
    k = ones([1 J])
else
    k = k_sam{2};
end

q = gamrnd(repmat(m, N, 1), 1./(repmat(m.*(r.^k), N, 1)))
q = q.^(1./k)
x = rand(N,J);
q(x > p) = Inf;
x = q;


[deaths,adherence_indices] = min(x,[],2);

censored = rand([N 1]);
censored(censored < lost_rate) = 1;
censored(censored ~= 1) = 0;

adherence_indices(censored == 1) = 0;


for i = 1:N
    if censored(i) == 1
        deaths(i) = deaths(i) / 2;
    end
end
       

y = {J,p,m,r,k, adherence_indices, censored, x, deaths};
end