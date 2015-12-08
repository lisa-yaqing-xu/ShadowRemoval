function I = CorrectMeanValue(I,m_desired)
% Program CorrectMeanValue.m
% =======================================================
% This function changes the mean value of a 2D array 
% (e.g., a *one channel* image) to match 
% a desired value (correction is done by uniform shifting)
% 
% Input:
%   I = 2D array (one channel image, with the first dimension corresponding
%       to the image height, and the second the image width)
%   m_desired = a scalar indicating the desired mean value
% Output:
%   I = 2D array with the values shifted such that the mean value is m_desired
%   
% Example: 
%   I = imread('eight.tif');
%   Is = CorrectMeanValue(I,120);
% 
% Note:
%   The values are not clipped back to [0..255]
%   The type of the output is 'double'
I = double(I);
[r,c] = size(I); 
I = I(:); 
m_input = mean(I);
d = m_desired - m_input;
I = I + d;
I = reshape(I,r,c);