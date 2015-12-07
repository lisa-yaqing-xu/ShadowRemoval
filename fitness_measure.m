function[phi] = fitness_measure(grad, mu, sigma)
    phi = exp(-(grad-mu)^2/(2*sigma^2))/sqrt(2*pi*sigma^2);
