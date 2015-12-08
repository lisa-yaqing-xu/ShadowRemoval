function [dxF,dyF] = ConvertGradientHF(dxH,dyH)
% Converts gradients computed in Hudgin into Fried geometry
% (please see Sec.2.2 in Reference 1 for discretization equations).
% Input: 
%       dxH, dyH = gradient data computed via Hudgin geometry
% Output: 
%       dxF, dyF = gradient data computed via Fried geometry
%
% Note: If an image is (m x n) 
%       the Hudgin gradients will be dx (m x n-1) and dy (m-1 x n) 
%       the Fried gradients will be (m-1 x n-1)
% References: 
% 1. I. S. Sevcenco, P. Hampton, P. Agathoklis, "A wavelet based method 
% for image reconstruction from gradient data with applications", 
% Multidimensional Systems and Signal Processing, November 2013

dxF = 0.5*(dxH(1:end-1,:,:) + dxH(2:end,:,:));
dyF = 0.5*(dyH(:,1:end-1,:) + dyH(:,2:end,:));