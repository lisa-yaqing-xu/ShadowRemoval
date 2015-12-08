function  R = ImageRecH(gxH,gyH,meanval,PoissonOn,no_iter)
% Program ImageRecH.m
% -------------------------------------------------------------------
% This function reconstructs an image from its Hudgin gradient 
% (please see Sec.2.2 in Ref. 1 for Hudgin gradient discretization Equations).  
% The program works for both multi-channel (e.g., color), 
% as well as for one channel (e.g., grayscale) images.
%
% Inputs: 
%       gxH and gyH = Hudgin gradients used to reconstruct the image; 
%                     should be two matrices of the same size 
%                     as the image to be reconstructed 
%                     (last column in gxH should be 0; last row in gyH should be 0);
%       meanval = if the image is color, should be a 3 x 1 vector storing 
%                 the mean value of the image we want to reconstruct 
%                 (one scalar per channel, meanval(1) corresponding to R,
%                 meanval(2) corresponding to G, meanval(3) corresponding to B 
%       PoissonOn = binary flag for Poisson solver during reconstruction 
%             can be: 0: Poisson solver is not used during reconstruction
%                     1: Poisson solver is used during reconstruction
%       no_iter = number of iterations used in the Poisson solver;
%                 -- if no Poisson solver is used in the reconstruction, then
%                 the value of no_iter is irrelevant, and set to 0 by
%                 default;
%                 -- if the Poisson solver is used in the reconstruction,
%                 a suggested value for the number of iterations is three
%                 (default)
%                 -- the user can also specify the desired number of
%                 iterations (acceptable values are positive integers, greater than 1)
% Output: R = reconstructed image
%
% For Examples of how to use the function please consult the
% documentation included in our submission (DocumentationToolbox.pdf)
% 
% References:
% 
% [1] I. S. Sevcenco, P. Hampton, P. Agathoklis, "A wavelet based method 
% for image reconstruction from gradient data with applications", 
% Multidimensional Systems and Signal Processing, November 2013
% 
% Earlier references using Fried gradient discretization (see sec. 2.1. in [1]):
% 
% [2] P. Hampton, P. Agathoklis, C. Bradley, "A New Wave-Front Reconstruction 
% Method for Adaptive Optics Systems Using Wavelets", IEEE Journal of 
% Selected Topics in Signal Processing, vol. 2, no. 5, October 2008
% 
% [3] P. Hampton, P. Agathoklis, "Comparison of Haar Wavelet-based and Poisson-based
% Numerical Integration Techniques", 2010

% Written by: Ioana Sevcenco, University of Victoria% 
% Last updated: August 28th, 2014
if (PoissonOn==0) && (nargin < 5),
    no_iter = 0; % not used, but defined to avoid compiling errors
end
if (PoissonOn==1) && (nargin < 5),
    no_iter = 3; % suggested number of iterations    
end;
if (size(gxH,3) == 3) % i.e., if image is three channel
        [dx_rec1,dx_rec2,dx_rec3] = splitRGB(gxH);
        [dy_rec1,dy_rec2,dy_rec3] = splitRGB(gyH);        
        R1 = OneChannelRec(dx_rec1,dy_rec1,PoissonOn,meanval(1),no_iter); 
        R2 = OneChannelRec(dx_rec2,dy_rec2,PoissonOn,meanval(2),no_iter); 
        R3 = OneChannelRec(dx_rec3,dy_rec3,PoissonOn,meanval(3),no_iter);                
        R = CombineRGB(R1,R2,R3);               
    else if (size(gxH,3) == 1) % i.e., if image is grayscale
                R = OneChannelRec(gxH,gyH,PoissonOn,meanval,no_iter);
         end
end