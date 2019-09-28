rng(10)
N = 100;

maxJ = 10;
a_J = 0.5;
a_p = 1;
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

y = generate_params_and_data(N,priorcoords, 0.05, {0}, {0}, {0}, {0}, {0});
[true_J, true_p, true_m, true_r, true_k, true_adherences, censored, true_x, deaths] = y{:}

%xx = [-10.005:0.01:10.005];
%plot(xx, exp(log_k_density(xx, k_a, k_b, k_c, 2)));

%y = k_sample(true_J, true_p, true_m, true_r, true_k, true_x, k_a, k_b, k_c, 2)
%true_k

y = J_sample(true_J, true_p, true_m, true_r, true_k, true_x, true_adherences, deaths, priorcoords);

