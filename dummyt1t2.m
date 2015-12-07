function[t1,t2] = dummyt1t2(ts,pixelset)
    [d_,ssize] = size(pixelset);
    p_diff = diff(pixelset); 
    edge = 1;
    max_grad = 0;
    for i = 2:ssize
        if max_grad < abs(p_diff(i-1)) && p_diff(i-1) < 0
        max_grad = abs(p_diff(i-1));
        edge = i;
        end
    end
    if(edge - 2 > 1)
        t1 = edge-2;
    else
        t1 = 1;
    end
    
    if(edge +2 < ssize)
        t2 = edge+2;
    else
        t2 = ssize;
    end