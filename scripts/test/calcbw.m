% test dummy code %
gradshadx = [];
gradshady = [];
gradshadnum = 0; %SAVE THIS VARIABLE IT'S USEFUL
cmean = mean(t1t2s(:,3));
shadowgrads = {};
for i = 1:w
    for j = 1:h
        if mask(i,j) == 0
            gradshadnum = gradshadnum + 1;
            averagec(i,j) = cmean;
            gradshadx(gradshadnum) = gxHb(i,j);
            gradshady(gradshadnum) = gyHb(i,j);
            shadowgrads{gradshadnum} = [i,j];
        end
    end
end
%Gmag_test = uint8(Gmag_n);
%}
[gradblx,gradbsx] = getLSGradients(sampleset,mask,gxHb);
normblx = fitdist(transpose(gradblx),'Normal');
normbsx = fitdist(transpose(gradbsx),'Normal');
normshadx = fitdist(transpose(gradshadx),'Normal');

[gradbly,gradbsy] = getLSGradients(sampleset,mask,gyHb);
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

Grad_nnx = gxHb;
Grad_nny = gyHb;

for i = 1:gradshadnum
    shad = shadowgrads{i};
    Grad_nnx(shad(1),shad(2)) = shadowgradtransf(gxHb(shad(1),shad(2)), mu_xs, sigma_xs, mu_xt, sigma_xt);
    Grad_nny(shad(1),shad(2)) = shadowgradtransf(gyHb(shad(1),shad(2)), mu_ys, sigma_ys, mu_yt, sigma_yt);
end

imconstr = ImageRecH(Grad_nnx,Grad_nny,meanvalbw,PoissonOn);
ac (:,:) = averagec(:,:);

newim (:,:) = imconstr(:,:) - ac(:,:);


imshow(uint8(newim));
%imshow(Gmag_test);
%{
bwcopy = double(bwcopy);
bwcopy = bwcopy - averagec;
bwcopy = uint8(bwcopy);
imshow(bwcopy);
%}