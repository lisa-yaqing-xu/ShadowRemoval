function[c,ct] = Clt(ts,pixelset,t1,t2,t) % ct = C(t)
    [d_,d] = size(pixelset);
    p_diff = diff(pixelset);
    
    max_i = 1;
    max_grad = 0;
    for i = 2:d
        if max_grad < abs(p_diff(i-1)) && p_diff(i-1) < 0
        max_grad = abs(p_diff(i-1));
        max_i = i;
        end
    end
    illum = 0;
    for i = 1:max_i;
        illum = illum + pixelset(i);
    end
    illum = illum/(max_i);
    illum2 = 0;
    for i = t2:d
        illum2 = illum2 + pixelset(i);
    end
    illum2 = illum2/(d-t2+1);
    
    ts2 = zeros (1,d-(t2-t1));
    pxset2 = zeros (1,d-(t2-t1)); 
    for i = 1:d
        if i <= t1
            pxset2(1,i) = 0;
            ts2(1,i) = ts(1,i);
        elseif i >= t2
            ts2(1,i-(t2-t1-1)) = ts(1,i);
            pxset2(1,i-(t2-t1-1)) = illum2-illum;
        end
    end
    cfit = fit(transpose(ts2),transpose(pxset2),'poly3');
    c = illum2-illum;
    if t < t1
        ct = 0;
    elseif t > t2;
        ct = c;
    else
        ct = cfit(t);
    end
    edge = max_i;
    %plot(cfit);
    %plot(ts,pxset2); 