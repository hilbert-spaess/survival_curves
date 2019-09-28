% log_integrate finds log(integral of exp(f)),given f, using a sampled grid
% defined by coords.

function y = log_integrate(N, f, coords)
cell_coords = num2cell(coords,2);
b = cell(1, N);
[b{:}] = ndgrid(cell_coords{:});
l = f(b);
for i = 1:N
    l = log_total(l);
end
y = l + sum(log(coords(:,2) - coords(:,1)));
end