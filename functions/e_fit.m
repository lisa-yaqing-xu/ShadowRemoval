function [efit] = e_fit(ts,pixelset,t1,t2,normd,grad)
    efit = 1;
    [s_,ssize] = size(ts);    
    for i = 2:ssize
        %calculate new gradient
        [c,ct,dct] = Clt(ts, pixelset,t1,t2,i);
        grad_n = grad(i-1) - dct;
        efit = efit * fitness_measure(grad_n, normd.mu, normd.sigma);
    end  
    efit = -efit;