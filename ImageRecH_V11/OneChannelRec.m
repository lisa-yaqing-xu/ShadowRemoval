% Program OneChannelRec.m
% -------------------------------------------------------------------
% This function reconstructs a *one channel* (i.e., grayscale) image 
% from a given *Hudgin* gradient using the Hampton Haar wavelet based algorithm;
% (please see Sec.2.2 in (1) for Hudgin gradient discretization Equations).
% Inputs: 
%       gxH and gyH = Hudgin gradient components that will be used to reconstruct
%                     the image; should be two matrices of the same size 
%                     as the image to be reconstructed (last column in gxH 
%                     is 0; last row in gyH is 0);
%       PoissonOn = binary flag for Poisson solver during reconstruction (1 to
%             include during reconstruction, 0 otherwise)
%       meanval = scalar, equal to or an estimate of the mean value of the 2D image
%       no_iter = number of iterations of Poisson solver
% Output: R = reconstructed 2D image
%
% Example: 
%   I = double(imread('eight.tif'));
%   [gxH,gyH] = getGradientH(I,1);
%   meanval = mean(I(:));
%   PoissonOn = 0;
%   R = OneChannelRec(gxH,gyH,avg,meanval);
%   figure, subplot(121),imshow(uint8(I)), title('original'); 
%   subplot(122),imshow(uint8(R)), title('reconstruction'); 
%
% Written by: Ioana Sevcenco
% Last updated: June 17, 2015
function R = OneChannelRec(gxH,gyH,PoissonOn,meanval,no_iter)
if PoissonOn==0 && nargin < 5,
    no_iter = 0; % not used, but defined to avoid compiling errors
end
if PoissonOn==1 && nargin < 5,
    no_iter = 3; % suggested number of iterations    
end;
no_rows_reconstruction = size(gxH,1);
no_cols_reconstruction = size(gyH,2); % change made here June 17, 2015 (previous code bug: gxH, instead of gyH)
[D,DX,DY] = GradientAnalysisH(gxH,gyH);
R = GradientSynthesisH(D,DX,DY,PoissonOn,no_iter);
R = R(1:no_rows_reconstruction,1:no_cols_reconstruction); % crop to desired value 
R = CorrectMeanValue(R,meanval);