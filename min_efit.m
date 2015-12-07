function[t1,t2] = min_efit(ts,pixelset)
    [s_,ssize] = size(ts);
    [c,ct,edge] = Clt(ts, pixelset,1,3,2);
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
    %min = 999999;
    %for i = 1:ssize-3
        %for j = i+1:i+3
            %efitval = e_fit(ts,pixelset,i,j);
            %if efitval < min
                %min = efitval;
                %t1 = i;
                %t2 = j;
            %end
        %end
    %end  