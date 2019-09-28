function y = m_density(m,a,b)
y = ((m.^(m.*b)) ./ ((gamma(m).^b))) .* exp(-m.*(a+b))
end