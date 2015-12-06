mask = imread('shadowmask.png');
img = imread('img.png');
brushsize = 7; %brush size in pixels

getShadowBoundary(img,mask,brushsize);
