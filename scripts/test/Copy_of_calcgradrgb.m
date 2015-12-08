% test dummy code %
gradshadxr = [];
gradshadxg = [];
gradshadxb = [];
gradshadyr = [];
gradshadyg = [];
gradshadyb = [];
gradshadnum = 0; %SAVE THIS VARIABLE IT'S USEFUL
cmeanr = mean(t1t2r(:,3));
cmeang = mean(t1t2g(:,3));
cmeanb = mean(t1t2b(:,3));
shadowgrads = {};
for i = 1:w
    for j = 1:h
        if mask(i,j) == 0
            gradshadnum = gradshadnum + 1;
            averagecr(i,j) = averagecr(i,j) + cmeanr;
            averagecb(i,j) = averagecb(i,j) + cmeanb;
            averagecg(i,j) = averagecg(i,j) + cmeang;

            gradshadxr(gradshadnum) = gxH(i,j,1);
            gradshadxg(gradshadnum) = gxH(i,j,2);
            gradshadxb(gradshadnum) = gxH(i,j,3);
            gradshadyr(gradshadnum) = gyH(i,j,1);
            gradshadyg(gradshadnum) = gyH(i,j,2);
            gradshadyb(gradshadnum) = gyH(i,j,3);
            shadowgrads{gradshadnum} = [i,j];
        end
    end
end
%Gmag_test = uint8(Gmag_n);
%}
[gradblxr,gradbsxr] = getLSGradients(sampleset,mask,gxH(:,:,1));
normblxr = fitdist(transpose(gradblxr),'Normal');
normbsxr = fitdist(transpose(gradbsxr),'Normal');
normshadxr = fitdist(transpose(gradshadxr),'Normal');
[gradblxg,gradbsxg] = getLSGradients(sampleset,mask,gxH(:,:,2));
normblxg = fitdist(transpose(gradblxg),'Normal');
normbsxg = fitdist(transpose(gradbsxg),'Normal');
normshadxg = fitdist(transpose(gradshadxg),'Normal');
[gradblxb,gradbsxb] = getLSGradients(sampleset,mask,gxH(:,:,3));
normblxb = fitdist(transpose(gradblxb),'Normal');
normbsxb = fitdist(transpose(gradbsxb),'Normal');
normshadxb = fitdist(transpose(gradshadxb),'Normal');

[gradblyr,gradbsyr] = getLSGradients(sampleset,mask,gyH(:,:,1));
normblyr = fitdist(transpose(gradblyr),'Normal');
normbsyr = fitdist(transpose(gradbsyr),'Normal');
normshadyr = fitdist(transpose(gradshadyr),'Normal');
[gradblyg,gradbsyg] = getLSGradients(sampleset,mask,gyH(:,:,2));
normblyg = fitdist(transpose(gradblyg),'Normal');
normbsyg = fitdist(transpose(gradbsyg),'Normal');
normshadyg = fitdist(transpose(gradshadyg),'Normal');
[gradblyb,gradbsyb] = getLSGradients(sampleset,mask,gyH(:,:,3));
normblyb = fitdist(transpose(gradblyb),'Normal');
normbsyb = fitdist(transpose(gradbsyb),'Normal');
normshadyb = fitdist(transpose(gradshadyb),'Normal');

mu_xrs = normshadxr.mu;
sigma_xrs = normshadxr.sigma;
mu_xrse = normbsxr.mu - normblxr.mu;
sigma_xrse2 = normbsxr.sigma^2 - normblxr.sigma^2;
mu_xrt = mu_xrs - mu_xrse;
sigma_xrt = sqrt(sigma_xrs^2-sigma_xrse2);
mu_xgs = normshadxg.mu;
sigma_xgs = normshadxg.sigma;
mu_xgse = normbsxg.mu - normblxg.mu;
sigma_xgse2 = normbsxg.sigma^2 - normblxg.sigma^2;
mu_xgt = mu_xgs - mu_xgse;
sigma_xgt = sqrt(sigma_xgs^2-sigma_xgse2);
mu_xbs = normshadxb.mu;
sigma_xbs = normshadxb.sigma;
mu_xbse = normbsxb.mu - normblxb.mu;
sigma_xbse2 = normbsxb.sigma^2 - normblxb.sigma^2;
mu_xbt = mu_xbs - mu_xbse;
sigma_xbt = sqrt(sigma_xbs^2-sigma_xbse2);


mu_yrs = normshadyr.mu;
sigma_yrs = normshadyr.sigma;
mu_yrse = normbsyr.mu - normblyr.mu;
sigma_yrse2 = normbsyr.sigma^2 - normblyr.sigma^2;
mu_yrt = mu_yrs - mu_yrse;
sigma_yrt = sqrt(sigma_yrs^2-sigma_yrse2);
mu_ygs = normshadyg.mu;
sigma_ygs = normshadyg.sigma;
mu_ygse = normbsyg.mu - normblyg.mu;
sigma_ygse2 = normbsyg.sigma^2 - normblyg.sigma^2;
mu_ygt = mu_ygs - mu_ygse;
sigma_ygt = sqrt(sigma_ygs^2-sigma_ygse2);
mu_ybs = normshadyb.mu;
sigma_ybs = normshadyb.sigma;
mu_ybse = normbsyb.mu - normblyb.mu;
sigma_ybse2 = normbsyb.sigma^2 - normblyb.sigma^2;
mu_ybt = mu_ybs - mu_ybse;
sigma_ybt = sqrt(sigma_ybs^2-sigma_ybse2);

Grad_nnx = gxH;
Grad_nny = gyH;
for i = 1:gradshadnum
    shad = shadowgrads{i};
    Grad_nnx(shad(1),shad(2),1) = shadowgradtransf(gxH(shad(1),shad(2),1), mu_xrs, sigma_xrs, mu_xrt, sigma_xrt);
    Grad_nnx(shad(1),shad(2),2) = shadowgradtransf(gxH(shad(1),shad(2),2), mu_xgs, sigma_xgs, mu_xgt, sigma_xgt);
    Grad_nnx(shad(1),shad(2),3) = shadowgradtransf(gxH(shad(1),shad(2),3), mu_xbs, sigma_xbs, mu_xbt, sigma_xbt);
    Grad_nny(shad(1),shad(2),1) = shadowgradtransf(gyH(shad(1),shad(2),1), mu_yrs, sigma_yrs, mu_yrt, sigma_yrt);
    Grad_nny(shad(1),shad(2),2) = shadowgradtransf(gyH(shad(1),shad(2),2), mu_ygs, sigma_ygs, mu_ygt, sigma_ygt);
    Grad_nny(shad(1),shad(2),3) = shadowgradtransf(gyH(shad(1),shad(2),3), mu_ybs, sigma_ybs, mu_ybt, sigma_ybt);
end

for i=1:3
    Grad_nnx(:,:,1) = Grad_nnx(:,:,1) + derivcr;
    Grad_nnx(:,:,2) = Grad_nnx(:,:,2) + derivcg;
    Grad_nnx(:,:,3) = Grad_nnx(:,:,3) + derivcb;
end

imconstr = ImageRecH(Grad_nnx,Grad_nny,meanval,PoissonOn);
newim = ImageRecH(Grad_nnx,Grad_nny,meanval,PoissonOn);
%imshow(imconstr);
%imshow(uint8(imconstr));

acr = averagecr;
acg = averagecg;
acb = averagecb;

newim(:,:,1) = imconstr(:,:,1) - acr;
newim(:,:,2) = imconstr(:,:,2) - acg;
newim(:,:,3) = imconstr(:,:,3) - acb;

imshow(uint8(newim));
%imshow(Gmag_test);
%{
bwcopy = double(bwcopy);
bwcopy = bwcopy - averagec;
bwcopy = uint8(bwcopy);
imshow(bwcopy);
%}