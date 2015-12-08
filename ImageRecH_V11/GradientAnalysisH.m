function [NewD,XX,YY] = GradientAnalysisH(dxH,dyH)
% program GradientAnalysisH.m
% ===========================
% This function obtains the Haar decomposition of an image from the Hudgin
% gradients - assuming zero Neumann condition, i.e., the gradients are zero
% on the boundary (please see Sec.2.2 in Reference 1 for discretization equations). 
% Inputs:
%   dxH, dyH = Hudgin gradient horizontal and vertical components,
%              respectively (Neumann boundary conditions, i.e. last row of 
%              dxH is zero, last column of dyH is zero)
% Outputs:
%   NewD = Haar wavelet decomposition of signal to be reconstructed
%   XX, YY = multigrid representations of the filtered gradient data that
%            are used in the smoothing portion of synthesis (i.e., for
%            Poisson smoothing)
% Written by: Ioana Sevcenco, University of Victoria
% 
% References: 
% [1] I.S. Sevcenco, P.J. Hampton, P. Agathoklis, "A wavelet based method 
% for image reconstruction from gradient data with applications", 
% Multidimensional Systems and Signal Processing, November 2013
% 
% [2] P.J. Hampton, P. Agathoklis, C. Bradley, "A New Wave-Front Reconstruction 
% Method for Adaptive Optics Systems Using Wavelets", IEEE Journal of 
% Selected Topics in Signal Processing, vol. 2, no. 5, October 2008
% 
% First version: Jan 30, 2012
% Last Updated: August 21st, 2014
dxH = dxH(:,1:end-1,:); % crop out last column of zeros
dyH = dyH(1:end-1,:,:); % crop out last row of zeros

[dxH,dyH] = ReflectH(dxH,dyH); % Reflects gradient components in case 
                               % of non-square, non-power of two inputs
[~,dxHy] = getGradientH(dxH); % compute second order mixed Hudgin derivative, for HH
[dyHx,~] = getGradientH(dyH); % compute second order mixed Hudgin derivative, for HH
HH = (dyHx+dxHy)/4; % scale back
HH = HH(1:2:end,1:2:end);  % downsample

[dxF,dyF] = ConvertGradientHF(dxH,dyH); % convert given Hudgin to to Fried derivatives
HL = dxF(1:2:end,1:2:end); % HL obtained from Fried x gradient
LH = dyF(1:2:end,1:2:end); % LH  obtained from Fried y gradient

[D_from_algorithm,XX,YY] = GradientAnalysis(dxF,dyF);
LL_from_algorithm = D_from_algorithm(1:end/2,1:end/2);

NewD = [LL_from_algorithm HL; LH HH];