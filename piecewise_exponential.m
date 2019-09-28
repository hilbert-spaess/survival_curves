function y = piecewise_exponential(points,vals,grads,bounds)
shifted_points = [points(2:end),Inf];
shifted_bounds = [bounds(2:end),Inf];
weights = (1./grads) .* (exp(grads.*(shifted_bounds-points)+vals)-exp(grads.*(bounds-points)+vals));
z = general_discrete(weights);
u = rand .* weights(z);
y = [((1./grads(z)).*log((grads(z).*u)+exp(grads(z).*(bounds(z)-points(z))+vals(z))))+points(z)-(vals(z)./grads(z)),z];
end