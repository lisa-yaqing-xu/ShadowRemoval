function [dzdx dzdy] = Reflect(dzdx,dzdy)
% program Reflect.m
% Extends rectangular data to fill a square by reflecting the gradient data
% Written by: Peter Hampton, Copyright August 2008
% 
% Reference:
% 1. P. Hampton, P. Agathoklis, C. Bradley, "Wavefront reconstruction
% over a circular aperture using gradient data extrapolated via the 
% mirror equations", Applied Optics, 48(20):4018–4030, Jul. 2009
%
% Commented and updated by: Ioana Sevcenco, 2014
%
%  The truncation below is done to prevent using input data that is too high
%  and could result in a software crash due to system memory limitations
[row col] = size(dzdx);
if row > 4095
    dzdx = dzdx(1:4095,:);
    dzdy = dzdy(1:4095,:);
end
if col > 4095
    dzdx = dzdx(:,1:4095);
    dzdy = dzdy(:,1:4095);
end
[row col] = size(dzdx);
M = ceil(log2(size(dzdx)+1));
dzdx(row+1:2^M(1),:) = dzdx(row:-1:1+2*row-2^M(1),:);
dzdx(:,col+1:2^M(2)) = -dzdx(:,col:-1:1+2*col-2^M(2));
dzdy(row+1:2^M(1),:) = -dzdy(row:-1:1+2*row-2^M(1),:);
dzdy(:,col+1:2^M(2)) = dzdy(:,col:-1:1+2*col-2^M(2));
%only one of the following for loops will execute
for k = M(1):M(2)-1
    dzdx(2^k+1:2^(k+1),:) = dzdx(2^k:-1:1,:);
    dzdy(2^k+1:2^(k+1),:) = -dzdy(2^k:-1:1,:);
end
for k = M(2):M(1)-1
    dzdx(:,2^k+1:2^(k+1)) = -dzdx(:,2^k:-1:1);
    dzdy(:,2^k+1:2^(k+1)) = dzdy(:,2^k:-1:1);
end