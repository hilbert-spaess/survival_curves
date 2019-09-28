function y = J_sample(J, p, m, r, k, x, adherences, deaths, priorcoords)
N = size(x)
N = N(1)

adherence_grid = zeros(N, J);
for i = 1:N
    if(adherences(i) > 0);
        adherence_grid(i,adherences(i)) = 1;
    end
end
adherences = adherences
adherence_grid = adherence_grid


maxJ = priorcoords{1};

used = sum(adherence_grid);
used(used ~= 0) = 1;
modes_full = sum(used)
old_modes_empty = J - modes_full
unused_addresses = find(used == 0);

newJ = randi([modes_full maxJ])
modes_empty = newJ - modes_full
o = old_modes_empty
if modes_empty < o
    l = old_modes_empty - modes_empty;
    for i = 1:l
        z = randi([1 o]);
        z = z
        used = used
        unused_addresses = unused_addresses
        used(unused_addresses(z)) = -1;
        unused_addresses(z) = [];
        o = o -1;
    end
    J = modes_empty + modes_full;
    index = find(used ~= -1);
    p = p(index)
    k = k(index)
    m = m(index)
    r = r(index)
    x = x(:,index)
    adherence_grid = adherence_grid(:,index)
    adherences = zeros([N 1])
    for i = 1:N
        zz = find(adherence_grid(i)==1)
        if not(isempty(find(adherence_grid(i) == 1)))
            disp("here")
            adherences(i) = find(adherence_grid(i)==1);
        end
    end
    adherences = adherences
elseif modes_empty > old_modes_empty
    
    newdata = generate_params_and_data(N, priorcoords, 0, {1, modes_empty - old_modes_empty}, {0}, {0}, {0}, {0});
    deaths = deaths
    newx = newdata{end-1}
    newx >= deaths
    keep = prod(newx >= deaths)
    keep = find(keep == 1)
    n_new = length(keep)
    
    J = J + n_new
    x = x
    keep = keep
    newx(keep) = newx(keep);
    newx(:,keep) = newx(:,keep);
    length(x)
    x = horzcat(x,newx(:,keep))
    length(x)
    p
    p = horzcat(p,newdata{2}(:,keep))
    m
    m = horzcat(m,newdata{3}(:,keep))
    r
    r = horzcat(r,newdata{4}(:,keep))
    k
    k = horzcat(k,newdata{5}(:,keep))
end

y = {J, p, k, m, r, x, adherences};

end