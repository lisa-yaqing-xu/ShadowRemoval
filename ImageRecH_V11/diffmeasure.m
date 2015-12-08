%  function s = diffmeasure(Orig, Approx, mea)
%  
%  Computes different measures to allow comparison between an original and
%  approximated version of a signal.
% 
%  Input:
%       Orig = Original data
%       Approx = approximated data
%           Can be vectors or matrices, but must be of the same size
%       mea = 'snr'  for SNR 
%           = 'psnr' for PSNR
%           = 'mse'  for MSE
%           = 're'   for relative error
%           = 'rms'  for root mean square error
%           = 'nrms' for normalized RMS
%           = 'ssim' for structural similarity
%           = 'gmsd' for gradient magnitude similarity deviation
%  Note: 
%       the input "mea" is not key sensitive, it can be all lower case or all
%       capital letters
% 
%  Output:
%       snr                                                     - verified
%       psnr                     - verified, for 0..255, i.e. 8 bits image
%       mean squared error                                      - verified
%       relative error                                          - verified
%       root mean square error                                  - verified
%       normalized root mean squared error                      - verified
% 
%  Example:
%       s = diffmeasure(Orig, Approx, 'snr')
%       s = diffmeasure(Orig, Approx, 're')
%
%  References:
% (1) Z. Wang, A. C. Bovik, H. R. Sheikh and E. P. Simoncelli, "Image quality 
%     assessment: From error visibility to structural similarity", IEEE 
%     Transactions on Image Processing, vol. 13, no. 4, pp. 600-612, Apr. 2004.
% (2) Wufeng Xue, Lei Zhang, Xuanqin Mou, and Alan C. Bovik, "Gradient Magnitude 
%     Similarity Deviation: A Highly Efficient Perceptual Image Quality Index", 
%     IEEE Transactions on Image Processing, 2014
% 
%  Written by: Ioana - March 6, 2011
%  Modified: July 31, 2013 -- cast input images to double to avoid failing
%  to compare input images of different kinds
% Updated June 2014, MATLAB 2014a, included ssim
function s = diffmeasure(Orig, Approx, mea)
if isequal(size(Orig),size(Approx))==0
    disp('The two compared inputs must be of the same size!')
    return
end
siz = size(Orig);
% if nargin < 3,
%    disp('Not sufficient input elements for comparison. Correct syntax: diffmeasure(Orig, Approx, [mea])');
%         return;
% end
    
orig = Orig(:);
aprx = Approx(:);
e = orig - aprx; 
switch mea
    case {'snr','SNR'}
        s = 20*log10(norm(orig)/norm(e));
    case {'mse','MSE'}
        s = sum(e.^2)/numel(e);
    case {'re','RE'}
        s = norm(e)/norm(orig);
    case {'psnr','PSNR'}
        s = 20*log10((2^8-1)/sqrt(sum(e.^2)/numel(e)));
    case {'rms','RMS'}
        s = sqrt(sum(e.^2)/numel(e));
    case {'nrms','NRMS'}
        s = sqrt(sum(e.^2)/numel(e))/std(orig);
    case {'fro'}
        s = norm(e);
    case {'ssim','SSIM'}
        s = ssim(reshape(orig,siz),reshape(aprx,siz));
end
