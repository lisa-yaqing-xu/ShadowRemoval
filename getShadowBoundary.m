function[] = getShadowBoundary(img,mask)
    I = rgb2gray(img);
    [Gmag, Gdir] = imgradient(I,'sobel');
    %imshowpair(Gmag, Gdir, 'montage');
    