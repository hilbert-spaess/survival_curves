%Quick for a small number of weights

function y = general_discrete(weights)
s = sum(weights);
v = s * rand;
i = 1;
t = weights(1);
while v > t
    i = i+1;
    t = t + weights(i);
end
y = i;
end