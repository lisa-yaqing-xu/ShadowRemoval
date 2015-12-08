% Program splitRGB.m
% Given a multichannel image, this function separates it in its R, G and B channels 
% and returns each matrix as an output, and the mean value in each channel.
% 
% Inputs: 
%   I = color image
%   display_channels = optional input; should be set to 1 if we want to
%                      see each channel
% 
% Outputs:
%   R, G, B = the three channels
%   mr, mg, mb = the mean value in each channel
%
% Example: 
%   I = double(imread('peppers.png'));
%   [R,G,B,mr,mg,mb] = splitRGB(I,1); 

function [R,G,B,mr,mg,mb] = splitRGB(I,display_channels)
if nargin<2
    display_channels = 0;
end
R = I(:,:,1);
mr = mean(R(:));

G = I(:,:,2);
mg = mean(G(:));

B = I(:,:,3);
mb = mean(B(:));

if display_channels
    % Clear the other color channels and display channels individually
    R_disp = zeros(size(I));
    R_disp(:,:,1) = R; 

    G_disp = zeros(size(I));
    G_disp(:,:,2) = G;

    B_disp = zeros(size(I));
    B_disp(:,:,3) = B;

    figure;
    subplot(131); imshow(uint8(R_disp)); title('Red channel');
    subplot(132); imshow(uint8(G_disp)); title('Green channel');
    subplot(133); imshow(uint8(B_disp)); title('Blue channel');
end