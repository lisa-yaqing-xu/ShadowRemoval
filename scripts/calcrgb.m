% test dummy code %
gradshadx = [];
gradshady = [];
gradshadnum = 0; %SAVE THIS VARIABLE IT'S USEFUL
cmeanr = mean(t1t2r(:,3));
cmeang = mean(t1t2g(:,3));
cmeanb = mean(t1t2b(:,3));
shadowgrads = {};
for i = 1:w
    for j = 1:h
        if mask(i,j) == 0
            gradshadnum = gradshadnum + 1;
            averagecr(i,j) = cmeanr;
            averagecb(i,j) = cmeanb;
            averagecg(i,j) = cmeang;

            gradshadx(gradshadnum) = gxH(i,j);
            gradshady(gradshadnum) = gyH(i,j);
            shadowgrads{gradshadnum} = [i,j];
        end
    end
end
%Gmag_test = uint8(Gmag_n);
%}
[gradblx,gradbsx] = getLSGradients(sampleset,mask,gxH);
normblx = fitdist(transpose(gradblx),'Normal');
normbsx = fitdist(transpose(gradbsx),'Normal');
normshadx = fitdist(transpose(gradshadx),'Normal');

[gradbly,gradbsy] = getLSGradients(sampleset,mask,gyH);
normbly = fitdist(transpose(gradbly),'Normal');
normbsy = fitdist(transpose(gradbsy),'Normal');
normshady = fitdist(transpose(gradshady),'Normal');

mu_xs = normshadx.mu;
sigma_xs = normshadx.sigma;
mu_xse = normbsx.mu - normblx.mu;
sigma_xse2 = normbsx.sigma^2 - normblx.sigma^2;
mu_xt = mu_xs - mu_xse;
sigma_xt = sqrt(sigma_xs^2-sigma_xse2);

mu_ys = normshady.mu;
sigma_ys = normshady.sigma;
mu_yse = normbsy.mu - normbly.mu;
sigma_yse2 = normbsy.sigma^2 - normbly.sigma^2;
mu_yt = mu_ys - mu_yse;
sigma_yt = sqrt(sigma_ys^2-sigma_yse2);

%G_nnx = gxH;
%G_nny = gyH;

Grad_nnx = gxH;
Grad_nny = gyH;

for i = 1:gradshadnum
    shad = shadowgrads{i};
    Grad_nnx(shad(1),shad(2)) = shadowgradtransf(gxH(shad(1),shad(2)), mu_xs, sigma_xs, mu_xt, sigma_xt);
    Grad_nny(shad(1),shad(2)) = shadowgradtransf(gyH(shad(1),shad(2)), mu_ys, sigma_ys, mu_yt, sigma_yt);
end


    
imconstr = ImageRecH(Grad_nnx,Grad_nny,meanval,PoissonOn);
newim = ImageRecH(Grad_nnx,Grad_nny,meanval,PoissonOn);
%imshow(imconstr);
%imshow(uint8(imconstr));

acr(:,:) = averagecr(:,:);
acg(:,:) = averagecg(:,:);
acb(:,:) = averagecb(:,:);

newim(:,:,1) = imconstr(:,:,1) - acr(:,:);
newim(:,:,2) = imconstr(:,:,2) - acg(:,:);
newim(:,:,3) = imconstr(:,:,3) - acb(:,:);

imshow(uint8(newim));
%imshow(Gmag_test);
%{
bwcopy = double(bwcopy);
bwcopy = bwcopy - averagec;
bwcopy = uint8(bwcopy);
imshow(bwcopy);
%}