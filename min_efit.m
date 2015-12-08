function[t1,t2] = min_efit(ts,pixelset)
    [t1,t2] = dummyt1t2(ts,pixelset);
    [s_,ssize] = size(ts);  
    %%{
    min = 999999;
    for i = 1:ssize-4
        for j = i+1:ssize
            efitval = e_fit(ts,pixelset,i,j);
            if efitval < min
                min = efitval;
                t1 = i;
                t2 = j;
            end
        end
    end 
    %%}