[w, h] = size(img(:,:,1));
[s_,ssize] = size(sampleset);

visitedtimes = zeros(w,h);

derivcr = zeros(w,h);
derivcg = zeros(w,h);
derivcb = zeros(w,h);

averagecr = zeros(w,h);
averagecg = zeros(w,h);
averagecb = zeros(w,h);



t1t2r = zeros(ssize,3);
t1t2g = zeros(ssize,3);
t1t2b = zeros(ssize,3);

tic
for i = 1:ssize;
    s = sampleset{i};
    
    [tvals, pxvals1, indicies] = getSample(s,imdoub(:,:,1));
    
    [d_,d] = size(pxvals1);
    [tr1,tr2] = min_efit(tvals,pxvals1);
    %%{
    ctotr = 0;
    for j = 2:d-1
        [cr,ctr,dctr] = Clt(tvals, pxvals1,tr1,tr2,j);
        averagecr(indicies(j,1),indicies(j,2)) = averagecr(indicies(j,1),indicies(j,2)) + ctr;
        derivcr(indicies(j,1),indicies(j,2)) = derivcr(indicies(j,1),indicies(j,2)) + dctr;
        visitedtimes(indicies(j,1),indicies(j,2)) = visitedtimes(indicies(j,1),indicies(j,2)) + 1;
        ctotr = ctotr+cr;
    end
    %}
    t1t2r(i,1) = tr1;
    t1t2r(i,2) = tr2;
    t1t2r(i,3) = ctotr/(d-2);
end
toc
for i = 1:ssize;
    s = sampleset{i};
    [tvals, pxvals2, indicies] = getSample(s,imdoub(:,:,2));
    [d_,d] = size(pxvals2);
    [tg1,tg2] = min_efit(tvals,pxvals2); %g
    ctotg = 0;
    for j = 2:d-1
        [cg,ctg,dctg] = Clt(tvals, pxvals2,tg1,tg2,j);
        averagecg(indicies(j,1),indicies(j,2)) = averagecg(indicies(j,1),indicies(j,2)) + ctg;
        derivcg(indicies(j,1),indicies(j,2)) = derivcg(indicies(j,1),indicies(j,2)) + dctg;
        ctotg = ctotg+cg;
    end

    t1t2g(i,1) = tg1;
    t1t2g(i,2) = tg2;
    t1t2g(i,3) = ctotg/(d-2);
end
toc
for i = 1:ssize;
    s = sampleset{i};
    
    [tvals, pxvals3, indicies] = getSample(s,imdoub(:,:,3));
    
    [d_,d] = size(pxvals3);
    [tb1,tb2] = min_efit(tvals,pxvals3); %b
    ctotb = 0;
    for j = 2:d-1
        [cb,ctb,dctb] = Clt(tvals, pxvals3,tb1,tb2,j);
        averagecb(indicies(j,1),indicies(j,2)) = averagecb(indicies(j,1),indicies(j,2)) + ctb;
        derivcb(indicies(j,1),indicies(j,2)) = derivcb(indicies(j,1),indicies(j,2)) + dctb;
        ctotb = ctotb+cb;
    end

    t1t2b(i,1) = tb1;
    t1t2b(i,2) = tb2;
    t1t2b(i,3) = ctotb/(d-2);
end
toc


visitedtimes(visitedtimes==0) = 1;
averagecr = averagecr ./ visitedtimes;
averagecg = averagecg ./ visitedtimes;
averagecb = averagecb ./ visitedtimes;
derivcr = derivcr ./ visitedtimes;
derivcg = derivcg ./ visitedtimes;
derivcb = derivcb ./ visitedtimes;