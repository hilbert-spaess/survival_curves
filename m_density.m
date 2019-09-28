function y = log_m_density(m,a,b)
y = (m.*b.*log(m)) - (b .* gammaln(m)) - (m.*(a+b));
end