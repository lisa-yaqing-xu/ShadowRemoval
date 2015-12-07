mask = imread('mask2.png');
img = imread('img2.jpg');
brushsize = 7; %brush size in pixels

[sampleset,bw] = getShadowBoundary(img,mask,brushsize);
bwcopy = bw;
%sampleset = [sampleStartColumn, sampleStartRow, sampleLength, sampleDirection]
[s_,ssize] = size(sampleset);
t1t2s = zeros(ssize,3);
for i = 1:ssize;
    s = sampleset{i};
    [tvals, pxvals, indicies] = getSample(s,bw);
    %[tvals, maskvals, indicies] = getSample(s,mask);
    [d_,d] = size(pxvals);
    [t1,t2] = min_efit(tvals,pxvals);  
    %%{
    ctot = 0;
    for j = 2:d-1
        [c,ct] = Clt(tvals, pxvals,t1,t2,j,0);
        bwcopy(indicies(j,1),indicies(j,2)) = bwcopy(indicies(j,1),indicies(j,2))-ct;
        ctot = ctot+c;
    end
    %}
    t1t2s(i,1) = t1;
    t1t2s(i,2) = t2;
    t1t2s(i,3) = ctot/(d-2);
end
% test dummy code %
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
