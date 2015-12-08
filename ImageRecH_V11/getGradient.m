function [dzdx, dzdy] = getGradient(ConservativeField)
% program getGradient.m
% This program computes the Fried derivatives of a 2D array;
% Input:
%   ConservativeField = 2d array, such as a grayscale digital image
% Output:
%   dzdx, dzdy = Fried gradient horizontal and vertical components
% Commented by: I. Sevcenco,
dzdx = ConservativeField(:,2:end,:) - ConservativeField(:,1:end-1,:);
dzdx = dzdx(2:end,:,:) + dzdx(1:end-1,:,:);
dzdx = dzdx*0.5;

dzdy = ConservativeField(2:end,:,:) - ConservativeField(1:end-1,:,:);
dzdy = dzdy(:,2:end,:) + dzdy(:,1:end-1,:);
dzdy = dzdy*0.5;