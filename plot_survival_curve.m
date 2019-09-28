function y = plot_survival_curve(ax, data, N)
    data = sort(data)
    size(data)
    plot(ax, data, N - [1:1:N])
end