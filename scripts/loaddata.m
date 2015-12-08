mask = imread(maskname);
img = imread(filename);
imdoub = double(img);
 
bw = rgb2gray(img);
bw = double(bw);
[sampleset,neighbors] = getShadowBoundary(mask,brushsize);

%bwcopy = bw;
%bw2 = rgb2gray(imgdoub);
%[Gmag, Gdir] = imgradient(bw,'sobel');
%[Gmagx, Gmagy] = imgradientxy(bw,'sobel');
%
[~,~,~,mr,mg,mb] = splitRGB(imdoub);
meanval = [mr,mg,mb];
meanvalbw = mean(bw(:));
[gxH,gyH] = getGradientH(imdoub,1);
[gxHb,gyHb] = getGradientH(bw,1);
PoissonOn = 1;




%testmethods