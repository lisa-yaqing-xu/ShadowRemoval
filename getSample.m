function[tvals, pxvals] = getSample(s, img)

sr = s(2);
scol = s(1);
slen = s(3);
sdir = s(4)
tvals = zeros(1,slen);
pxvals = zeros(1,slen);
for i=1:slen
    tvals(1,i) = i;
    %N,E,S,W = 0,1,2,3 
    if(sdir == 2)
        pxvals(1,i) = img(sr,scol-(i-1));
    elseif(sdir == 1)
        pxvals(1,i) = img(sr-(i-1),scol);    
    elseif(sdir == 0)
        pxvals(1,i) = img(sr,scol+(i-1));
    elseif(sdir == 3 )
        pxvals(1,i) = img(sr+(i-1),scol);    
    end        
end