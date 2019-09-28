function y = log_proposal_r_density(r,a,b,c)
y = (a.*log(r)) - (b.*(r.^c));
end