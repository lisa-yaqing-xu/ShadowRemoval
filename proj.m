mask = imread('shadowmask2.png');
img = imread('img.png');
brushsize = 7; %brush size in pixels

[sampleset,bw] = getShadowBoundary(img,mask,brushsize);
%sampleset = [sampleStartColumn, sampleStartRow, sampleLength, sampleDirection]
[s_,ssize] = size(sampleset);
t1t2s = zeros(ssize,2);
for i = 1:ssize;
    s = sampleset{i};
    [tvals, pxvals] = getSample(s,bw);
    [t1,t2] = min_efit(tvals,pxvals);
    t1t2s(i,1) = t1;
    t1t2s(i,2) = t2;
end