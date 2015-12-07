mask = imread('shadowmask2.png');
img = imread('img.png');
brushsize = 7; %brush size in pixels

[sampleset,bw] = getShadowBoundary(img,mask,brushsize);
bwcopy = bw;
%sampleset = [sampleStartColumn, sampleStartRow, sampleLength, sampleDirection]
[s_,ssize] = size(sampleset);
t1t2s = zeros(ssize,2);%3);
for i = 1:ssize;
    s = sampleset{i};
    [tvals, pxvals, indicies] = getSample(s,bw);
    [t1,t2] = min_efit(tvals,pxvals);
     %{
    [d_,d] = size(pxvals);
    for j = 2:d-1
        [c,ct] = Clt(tvals, pxvals,t1,t2,j);
        bwcopy(indicies(j,1),indicies(j,2)) = bwcopy(indicies(j,1),indicies(j,2))-ct;
    end
    %}
    t1t2s(i,1) = t1;
    t1t2s(i,2) = t2;
    t1t2s(i,3) = c;
end
% test dummy code %
%{
cmean = mean(t1t2s(:,3));
[w, h] = size(bwcopy);
for i = 1:w
    for j = 1:h
        if mask(i,j) == 0
            bwcopy(i,j) = bwcopy(i,j) - cmean;
        end
    end
end

imshow(bwcopy);
%}
