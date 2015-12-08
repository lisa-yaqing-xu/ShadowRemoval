function [dx_ext,dy_ext] = ReflectH( dxH,dyH )
% program ReflectH.m
% ==================
% This program extends Hudgin gradient components to nearest power of two to 
% ensure zero curl condition (please see Sec.2.2 in Reference 1 for Hudgin 
% discretization equations).
% Input gradients must be without row/ column of zeros
% Inputs:
%   dxH, dyH = Hudgin gradient horizontal and vertical components,
%              respectively (without assumption of Neumann boundary 
%              conditions; forward difference)
% Outputs:
%   dx_ext, dy_ext = extended gradients to the nearest power of two 
% 
% Written by: Ioana Sevcenco, University of Victoria
% 
% References: 
% 1. I. S. Sevcenco, P. Hampton, P. Agathoklis, "A wavelet based method 
% for image reconstruction from gradient data with applications", 
% Multidimensional Systems and Signal Processing, November 2013
% 
% 2. P. Hampton, P. Agathoklis, "Comparison of Haar Wavelet-based and Poisson-based
% Numerical Integration Techniques", 2010
% 
% 3. P. Hampton, P. Agathoklis, C. Bradley, "A New Wave-Front Reconstruction 
% Method for Adaptive Optics Systems Using Wavelets", IEEE Journal of 
% Selected Topics in Signal Processing, vol. 2, no. 5, October 2008
% 
%
% Last Updated: August 21st, 2014
given_rowx = size(dxH,1);
given_colx = size(dxH,2);

given_rowy = size(dyH,1);
given_coly = size(dyH,2);

s = max(given_rowx,given_coly);
M = nextpow2(s);

rowx = 2^M;
colx = 2^M-1;

rowy = 2^M-1;
coly = 2^M;

if (given_rowx~=rowx)||(given_rowy~=rowy)||(given_colx~=colx)||(given_coly~=coly),
    [dx_ext,dy_ext] = ReflectHC(dxH,dyH);

    new_rowx = size(dx_ext,1);
    new_colx = size(dx_ext,2);

    new_rowy = size(dy_ext,1);
    new_coly = size(dy_ext,2);

    while (new_rowx<rowx) || (new_rowy<rowy) || (new_colx<colx) || (new_coly<coly),
        if new_rowx>=rowx,
            dx_ext = dx_ext(1:rowx,:);
        end;
        if new_colx>=colx,
            dx_ext = dx_ext(:,1:colx);
        end;
        if new_rowy>=rowy,
            dy_ext = dy_ext(1:rowy,:);
        end;
        if new_coly>=coly,
            dy_ext = dy_ext(:,1:coly);
        end;
        [dx_ext,dy_ext] = ReflectHC(dx_ext,dy_ext);
        new_rowx = size(dx_ext,1);
        new_colx = size(dx_ext,2);
        new_rowy = size(dy_ext,1);
        new_coly = size(dy_ext,2);
    end
    if new_rowx>=rowx,
        dx_ext = dx_ext(1:rowx,:);
    end;
    if new_colx>=colx,
        dx_ext = dx_ext(:,1:colx);
    end;
    if new_rowy>=rowy,
        dy_ext = dy_ext(1:rowy,:);
    end;
    if new_coly>=coly,
        dy_ext = dy_ext(:,1:coly);
    end;
else
    dx_ext = dxH; dy_ext = dyH;
end   
end