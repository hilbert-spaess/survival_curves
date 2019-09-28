rng(165)

N = 100

% Declare prior constants. Letter after the underscore specifies which
% prior the constant is needed for.
%
% The forms of the priors are specified at the start of the corresponding
% sampling routine.

maxJ = 10;
a_J = 0.5;
a_p = 5;
b_p = 1;
a_m = 1;
b_m = 1;
a_r = 1;
b_r = 1;
a_k = 2;
b_k = {1 2};
c_k = {1 2};
l_k = 2;

priorcoords = {maxJ, a_J, a_p, b_p, a_m, b_m, a_r, b_r, a_k, b_k, c_k, l_k};

% Generate some sample data.

y = generate_params_and_data(N,priorcoords, 0.1, {0}, {0}, {0}, {0}, {0});
[true_J, true_p, true_m, true_r, true_k, true_adherences, censored, true_x, deaths] = y{:};

% Sample initial point for the Markov Chain.

y2 = generate_params_and_data(N,priorcoords, 0.1, {0}, {0}, {0}, {0}, {0});
[J, p, m, r, k, adherences, ignore1, x, ignore2] = y2{:};

ax1 = subplot(3,1,1);
ax2 = subplot(3,1,2);
ax3 = subplot(3,1,3);

% Toggle these variables between 0 and 1 to sample from the corresponding
% axes.

J_axis = 1
p_axis = 1
m_axis = 1
r_axis = 1
k_axis = 1
x_axis = 1
adherence_axis = 1

if not(J_axis)
    J = true_J
end

if not(x_axis)
    x = true_x
end


if not(p_axis)
    p = true_p
end


if not(r_axis)
    r = true_r
end


if not(m_axis)
    m = true_m
end

if not(adherence_axis)
    adherences = true_adherences
end

if not(k_axis)
    k = true_k
end

% Run palindromic sampling for I iterations.

I = 150

for i = 1:I
     i
     if k_axis
         k = k_sample(J, p, m, r, k, x, priorcoords);
     end
     if p_axis
        p = p_sample(J, p, m, r, k, x, a_p, b_p);
     end
     if m_axis
        m = m_sample(J, p, m, r, k, x, a_m, b_m);
     end
     if r_axis
        r = r_sample(J, p, m, r, k, x, a_r, b_r);
     end
     if x_axis
        x = x_sample(J, p, m, r, k, x, deaths, adherences, censored);
     end
     if adherence_axis
        adherences = adherence_sample(J, p, m, r, k, x, deaths, censored);
     end
     if J_axis
         y = J_sample(J, p, m, r, k, x, adherences, deaths, priorcoords);
         [J, p, k, m, r, x, adherences] = y{:}
     end
     if J_axis
         y = J_sample(J, p, m, r, k, x, adherences, deaths, priorcoords)
         [J, p, k, m, r, x, adherences] = y{:}
     end
     if x_axis
        x = x
        J = J
        x = x_sample(J, p, m, r, k, x, deaths, adherences, censored);
        disp("here")
        x = x
     end
     if r_axis
        r = r_sample(J, p, m, r, k, x, a_r, b_r);
     end
     if m_axis
        m = m_sample(J, p, m, r, k, x, a_m, b_m);
     end
     if p_axis
        p = p_sample(J, p, m, r, k, x, a_p, b_p);
     end
     if k_axis
         k = k_sample(J, p, m, r, k, x, priorcoords);
     end
end

% Sample from the most recent point of the chain.

y = generate_params_and_data(N, priorcoords, 0, {1,J}, {1,p}, {1,r}, {1,m}, {1,k});
ndeaths = y{end};
ndeaths(ndeaths > 100) = Inf;
deaths(deaths > 100) = Inf;

% Plot the survival curves for the sampled point and the original point.
plot_survival_curve(ax1,deaths,N)
plot_survival_curve(ax2, ndeaths, N)

% Plot an arbitrary survival curve from the prior.
y = generate_params_and_data(N,priorcoords, 0, {0}, {0}, {0}, {0}, {0});
z = y{end}
plot_survival_curve(ax3, z, N)