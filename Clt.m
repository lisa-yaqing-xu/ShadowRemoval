function[c,t1, t2,d] = Clt(ts,pixelset)
    [d_,d] = size(pixelset);
    p_diff1 = diff(pixelset)
    
    cfit = fit(transpose(ts),transpose(pixelset),'poly3');
    %plot(cfit);
    plot(ts,pixelset); 