function[t1,t2] = min_efit(ts,pixelset,grad)
    [t1,t2] = dummyt1t2(ts,pixelset);
    [s_,ssize] = size(ts);  
    %%{
    grad = diff(pixelset);
    normd = fitdist(transpose(grad),'Normal');
    min = 999999;
    for i = 1:ssize-4
        for j = i+1:ssize
            efitval = e_fit(ts,pixelset,i,j,normd,grad);
            if efitval < min
                min = efitval;
                t1 = i;
                t2 = j;
            end
        end
    end 
    %%}