mask = imread('shadowmask.png');
img = imread('img.png');
brushsize = 7; %brush size in pixels

[sampleset,bw] = getShadowBoundary(img,mask,brushsize);
%sampleset = [sampleStartColumn, sampleStartRow, sampleLength, sampleDirection]
[s_,ssize] = size(sampleset);
for i = 1:ssize
    s = sampleset{i};
    [tvals, pxvals] = getSample(s,mask);
    pxvals
end
Clt(tvals, pxvals);