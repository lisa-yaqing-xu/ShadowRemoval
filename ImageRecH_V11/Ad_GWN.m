function Xn = Ad_GWN(X,targetSNR,st)
% Input:
%             X  = original signal; can be any size
%     targetsnr  = desired SNR
%            st  = state for random seed (an integer number)
% Output:
%       Xn = noisy signal
% 
% Written by: Ioana Sevcenco, June 2014
% Adapted from a code written by: Richard Lyons [December 2011]
% http://www.dsprelated.com/showcode/263.php
xv = X(:);
randn('state',st);
noiseSig = randn(numel(xv),1); 
pwrSig = norm(xv)^2/length(xv);
pwrNoise = norm(noiseSig)^2/length(xv);
k = (pwrSig/pwrNoise)*10^(-targetSNR/10);
nxNew = sqrt(k)*noiseSig;
m = mean(nxNew(:)); % to ensure zero mean
nxNew = nxNew - m;
xvn = xv + nxNew;
Xn = reshape(xvn,size(X));