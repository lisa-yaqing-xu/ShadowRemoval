function I = CombineRGB(R,G,B)
% Program CombineRGB.m
% This program generates a three channel image (e.g., RGB, YCbCr, etc.) 
% from three single channel components.
% 
% Inputs: 
%   R,G,B = the three channels of the image; 
%           must be two dimensional arrays, with the first dimension
%           corresponding to the height ofthe image, and the second corresponding
%           to the width of the image    
% Output:
%   I = the multi-channel (color) image
if isequal(size(R),size(G),size(B))==0,
    disp('Sizes of the three arrays must be equal. Please check input data for consistency');
    return
else    
    I = zeros([size(R),3]);
    I(:,:,1) = R;
    I(:,:,2) = G;
    I(:,:,3) = B;
end
