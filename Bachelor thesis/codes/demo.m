
x = randn(10,10);
indices = find(x>2);
x(indices) = []

plot(length(x),x)