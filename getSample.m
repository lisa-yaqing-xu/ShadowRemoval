function[tvals, pxvals,indices] = getSample(s, img)

sr = s(2);
scol = s(1);
slen = s(3);
sdir = s(4);
tvals = zeros(1,slen);
pxvals = zeros(1,slen);
indices= zeros(slen,2);
for i=1:slen+2
    tvals(1,i) = i;
    %N,E,S,W = 0,1,2,3 
    if(sdir == 3)
        pxvals(1,i) = img(sr,scol+1-(i-1));
        indices(i,1) = sr;
        indices(i,2) = scol+1-(i-1);
    elseif(sdir == 0)
        pxvals(1,i) = img(sr+1-(i-1),scol);
        indices(i,1) = sr+1-(i-1);
        indices(i,2) = scol;
    elseif(sdir == 1)
        pxvals(1,i) = img(sr,scol-1+(i-1));
        indices(i,1) = sr;
        indices(i,2) = scol-1+(i-1);
    elseif(sdir == 2 )
        pxvals(1,i) = img(sr-1+(i-1),scol);  
        indices(i,1) = sr-1+(i-1);
        indices(i,2) = scol;
    end        
end

