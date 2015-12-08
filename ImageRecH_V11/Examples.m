%% Wavelet based Image Reconstruction from Gradient Data
% 
% Version 1.0
% I. Sevcenco, P. Hampton, P. Agathoklis
% Department of Electrical and Computer Engineering
% University of Victoria
% Victoria, B.C., Canada
% 
%% Introduction
% The *ImageRecH* toolbox can be used to reconstruct an image from gradient 
% data. The function *ImageRecH.m* can be used to reconstruct images that are 
% either single channel (i.e., grayscale) or multi channel (i.e., colour,
% in three channel representation, such as RGB). The theory behind this
% toolbox was developed in the papers [1], [2] and [3].
% 
% 
%% Example 1: Reconstruction of a single channel image (i.e., grayscale) from gradient data
% This example illustrates how the software ImageRecH.m can be used to reconstruct
% a single channel image (i.e., a grayscale image) from a gradient data set. 
% To illustrate how the algorithm works, the ground truth image is considered known, 
% and the reconstructed image will be compared against it.
% The goal is to use the gradient and the mean value of the image as inputs to the
% software (ImageRecH.m), output a reconstructed image and compare it to the original. 
% The output should be identical to the input in the case of clean, noise free input 
% gradient and after the correction of the mean value.
%%
% _Read grayscale image into workspace_
I = double(imread('moon.tif'));
%%
% _Compute mean value of the grayscale image_
meanval = mean(I(:));
%%
% _Compute the gradient of the grayscale image_
% Ensure boundary conditions are satisfied, i.e. the x-gradient is zero 
% on the last column and the y-gradient is zero on the last row
[gxH,gyH] = getGradientH(I,1);
%%
% _Reconstruct the image using the wavelet based algorithm [1]_
%%
% _First, specify whether or not Poisson smoothing is used in the reconstruction_
% Here, the Poisson solver is not used; to indicate this, the variable *PoissonOn* is set to 0.
PoissonOn = 0;
R = ImageRecH(gxH,gyH,meanval,PoissonOn);
%%
% _Display the original image side by side with the reconstructed_
figure, subplot(121), imshow(uint8(I)), title('original'), 
subplot(122), imshow(uint8(R)), title('reconstruction') 
%%
% _Compare reconstruction to ground truth_
% Returns 1 if they are equal
isequal(I,R)
%% Example 2: Reconstruction of a multi channel image (i.e., colour image, in RGB) from gradient data
% This example illustrates how the software ImageRecH.m can be used to reconstruct a 
% multichannel image (i.e., a colour image, in RGB representation) from a gradient 
% data set. To illustrate how the algorithm works, the ground truth image is 
% considered known, and the reconstructed image will be compared against it. 
% 
% The goal is to use the gradient and the mean value of each individual 
% color channels as inputs to the software (ImageRecH.m), output a reconstructed 
% image and compare it to the original. The output should be identical to 
% the input in the case of clean, noise free input gradient and after 
% the correction of the mean value.
% 
%%
% _Read colour image into workspace_
I = double(imread('gantrycrane.png'));
%%
% _Compute mean value of each channel of the colour image_
[~,~,~,mr,mg,mb] = splitRGB(I); 
%%
% _Store the three values in a vector_
meanval = [mr,mg,mb];
%%
% _Compute the gradient of the multichannel image_
% Ensure boundary conditions are satisfied, i.e. the x-gradient is zero 
% on the last column and the y-gradient is zero on the last row
[gxH,gyH] = getGradientH(I,1);
%%
% _Specify whether or not Poisson smoothing is used in the reconstruction_
% Here, the Poisson solver is *not* used; to indicate this, the variable PoissonOn is set to 0
PoissonOn = 0;
%%
% _Reconstruct the image using the wavelet based algorithm [1]_
R = ImageRecH(gxH,gyH,meanval,PoissonOn);
%%
% _Display the original image side by side with the reconstructed_
figure, subplot(121), imshow(uint8(I)), title('original'), 
subplot(122), imshow(uint8(R)), title('reconstruction')
%%
% _Compare reconstruction to ground truth_
% Returns 1 if they are equal
isequal(I,R)
%% Example 3: Reconstruction of a single channel image (i.e., grayscale) from noisy gradient data
% This example illustrates how the software ImageRecH.m can be used to reconstruct a single 
% channel image (i.e., a grayscale image) from a noisy gradient data set. To illustrate how 
% the algorithm works, the ground truth image is considered known. Then, the approximation of 
% its gradient is computed, noise is added to the gradient data, and reconstruction using the 
% wavelet based technique is attempted. To illustrate the role of the Poisson solver during 
% the synthesis stage, two reconstructions are generated: one without the Poisson solver, 
% and the other one with it. The two reconstructed images are displayed and compared against 
% the original.
%%
% _Read grayscale image into workspace_
I = double(imread('coins.png'));
%%
% _Compute mean value of the grayscale image_
meanval = mean(I(:));
%%
% _Compute the gradient of the grayscale image_
% Ensure boundary conditions are satisfied, i.e. the x-gradient is zero 
% on the last column and the y-gradient is zero on the last row)
[gxH,gyH] = getGradientH(I,1);
%%
% _Add Gaussian white noise to gradient_
% Specify desired SNR (in dB). In this example, noise was added to generate an SNR of 
% ~0dB in each gradient component.
dsnr = 0;
%%
% _Specify seed for random number generator, to allow result repeatability_
sdx = 3;
gxHn = Ad_GWN(gxH,dsnr,sdx);
%%
% _Ensure boundary conditions_
gxHn(:,end) = 0;
%%
% _Specify another seed for random number generator_
sdy = 7;
gyHn = Ad_GWN(gyH,dsnr,sdy);
%%
% _Ensure boundary conditions_
gyHn(end,:) = 0;
%%
% _Reconstruct the image using the wavelet based algorithm [1]_
% The variable |PoissonOn| should be set to:
%%
% 
% * 0 (zero) if the Poisson solver is not used 
% * 1 (one) if the Poisson solver is used
% When the Poisson solver is used, the user can specify a desired number of iterations.
% The recommended (and default) number of iterations for the Poisson solver is three. 
% If more iterations are needed, the user can set the desired number with 
% the following command:
% |no_iter = 7| ;
% The default number of iterations is three, and therefore the last input
% of the function |ImageRecH| is not required. If the user prefers to use 
% more than three iterations of the solver per resolution level, then 
% the function |ImageRecH| should be called with five input
% arguments, the last of which should be the desired number of iterations |no_iter| .
% |R = ImageRecH(gxH,gyH,meanval,PoissonOn,no_iter)| ; 
%%
% _First, reconstruct without the Poisson solver_
PoissonOn = 0;
R1 = ImageRecH(gxHn,gyHn,meanval,PoissonOn);
%%
% _Now, reconstruct with Poisson solver._ 
% In this example, the default configuration will be used (three iterations 
% per resolution level) 
PoissonOn = 1;
R2 = ImageRecH(gxHn,gyHn,meanval,PoissonOn);
%%
% Display the original image and the two reconstructions side by side.figure, 
figure, imshow(uint8(I)), title('Original image'), 
figure, imshow(uint8(R1)), title('Reconstructed without Poisson') 
xlabel(['Mean squared error: ',num2str(diffmeasure(I,R1,'mse'))]);
figure, imshow(uint8(R2)), title('Reconstruction with Poisson') 
xlabel(['Mean squared error: ',num2str(diffmeasure(I,R2,'mse'))]);
%%
% _Compare reconstruction to ground truth in terms of mean squared error_
diffmeasure(I,R1,'mse')
diffmeasure(I,R2,'mse')
%
% Written by: Ioana Sevcenco, University of Victoria 
% Last updated: Oct 6th, 2014
%% Acknowledgements
% 
% This document was created using images and publishing capabilities from 
% MATLAB 2014a.
% 
%% References
% 
% [1] I.S. Sevcenco, P.J. Hampton, P. Agathoklis, "A wavelet based method 
% for image reconstruction from gradient data with applications", 
% Multidimensional Systems and Signal Processing, November 2013
% 
% Earlier references using Fried gradient discretization (see sec. 2.1. in [1]):
% 
% [2] P.J. Hampton, P. Agathoklis, C. Bradley, "A New Wave-Front Reconstruction 
% Method for Adaptive Optics Systems Using Wavelets", IEEE Journal of 
% Selected Topics in Signal Processing, vol. 2, no. 5, October 2008
% 
% [3] P.J. Hampton, P. Agathoklis, "Comparison of Haar Wavelet-based and Poisson-based
% Numerical Integration Techniques", Proceedings of Circuits and Systems
% (ISCAS), pp.1623-1626, 2010