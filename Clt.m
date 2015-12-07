function[c,ct] = Clt(ts,pixelset,t1,t2,t,diffr) % ct = C(t)
    [d_,d] = size(pixelset);
    illum = 0;
    for i = 1:t1;
        illum = illum + pixelset(i);
    end
    illum = illum/(t1);
    illum2 = 0;
    for i = t2:d
        illum2 = illum2 + pixelset(i);
    end
    illum2 = illum2/(d-t2+1);
    %illum2 = illum2 + min(pixelset(t2:d));
    %illum2 = illum2/2;
    c = illum2-illum;
    [aa,bb,cc,dd] = solveCubic(t1,0,t2,c,0,0);
    if t < t1
        ct = 0;
    elseif t > t2;
        if(diffr)
            ct = 0;
        else
            ct = c;
        end
    else
        if(diffr)
            ct = 3*aa*t^2 + 2*bb*t + cc;
        else
            ct = aa*t^3 + bb*t^2 + cc*t +dd;
        end
        
    end
    %edge = max_i;
    %plot(cfit);
    %plot(ts,pxset2); 