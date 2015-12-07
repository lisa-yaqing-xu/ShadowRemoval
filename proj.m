mask = imread('mask1.png');
img = imread('img.png');
brushsize = 7; %brush size in pixels

[sampleset,bw] = getShadowBoundary(img,mask,brushsize);
bwcopy = bw;
%sampleset = [sampleStartColumn, sampleStartRow, sampleLength, sampleDirection]
[w, h] = size(bwcopy);

%testmethods
%%{
visitedtimes = zeros(w,h);
averagec = zeros(w,h);
%}
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
        averagec(indicies(j,1),indicies(j,2)) = averagec(indicies(j,1),indicies(j,2)) + ct;
        visitedtimes(indicies(j,1),indicies(j,2)) = visitedtimes(indicies(j,1),indicies(j,2)) + 1;
        ctot = ctot+c;
    end
    %}
    t1t2s(i,1) = t1;
    t1t2s(i,2) = t2;
    t1t2s(i,3) = ctot/(d-2);
end
visitedtimes(visitedtimes==0) = 1;
averagec = averagec ./ visitedtimes;

% test dummy code %
cmean = mean(t1t2s(:,3));

for i = 1:w
    for j = 1:h
        if mask(i,j) == 0
            averagec(i,j) = averagec(i,j) + cmean;
        end
    end
end

bwcopy = im2double(bwcopy)
bwcopy = bwcopy + averagec;
imshow(bwcopy);

%}
