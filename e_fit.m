function [efit] = e_fit(ts,pixelset,t1,t2)
    efit = 1;
    [s_,ssize] = size(ts);    
    grad = diff(pixelset);
    normd = fitdist(transpose(grad),'Normal');
    for i = 2:ssize
        %calculate new gradient
        [c,ct,edge] = Clt(ts, pixelset,t1,t2,i);
        grad_n = grad(i-1) - ct;
        efit = efit * fitness_measure(grad_n, normd.mu, normd.sigma);
    end  
    efit = -efit;