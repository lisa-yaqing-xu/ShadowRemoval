function [dzdx_ext,dzdy_ext] = ReflectHC(dzdx,dzdy)
[rowx, colx] = size(dzdx);
dzdx_ext(1:rowx,1:colx) = dzdx;

dzdx_ext(rowx+1:2*rowx-1,1:colx) = flipud(dzdx_ext(1:rowx-1,:)); % fill downwards first
dzdx_ext = [dzdx_ext -fliplr(dzdx_ext)];

[rowy, coly] = size(dzdy);
dzdy_ext(1:rowy,1:coly) = dzdy;

dzdy_ext(rowy+1:2*rowy,1:coly) = -flipud(dzdy_ext(1:rowy,1:coly)); % fill downwards first
dzdy_ext = [dzdy_ext fliplr(dzdy_ext(:,1:end-1))];