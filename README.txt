John Lenhard - 108265150 
Lisa Xu - 108059610

README

Paper: http://web.cecs.pdx.edu/~fliu/papers/eccv08.pdf

Anything in the ImageRecH_V11 folder belongs to the Wavelet Library. The rest are code written between me (Lisa) and John.
Wavelet Library: h​ttp://www.mathworks.com/matlabcentral/fileexchange/48066-wavelet-based-image-reconstructio n-from-gradient-data

To use:
Add the entire 527-proj folder to Matlab path.
Go into scripts and click on proj.m, putting in your image and pre-drawn (I like Photoshop) mask, with 255 denoting light area and 0 denoting umbra, and a single value inbetween (my masks are 105 or 106, PS turns 128 to that when converting to greyscale mode). I provided 2 test images, which were used in the actual paper as an example. 

Run proj.m. It runs 3 scripts: 
- loaddata.m, which loads the images and sets up the gradients, 
- getcrgb.m, which optimizes the illumination change and gets the t1/t2/c values and puts them in matrices
- calcrgb.m, which runs a bunch of normal distribution fits to get the umbra areas to have more texture when illumination change is applied. 

I used scripts instead of functions for these operations so I can easily control the variables to see what works and what doesn't.

Anyway, functions we wrote:
- getShadowBoundary.m - this takes the grey penumbra area highlighted and returns a cell with all the sampling lines in it, including start coordinates, length, and direction. Also neighbors for e_sm.m, but I didn't end up getting to use that.
- solveCubic.m - does exactly what it says on the tin. Take 2 points and their derivatives at those points, output coefficients for a cubic function.
- Clt.m - calculates c depending on t1/t2 and returns c, C(t), and C'(t) based on t and t1/t2 given.
- e_fit.m - calculates E_fit given t1/t2 (to plug into Clt) and the new gradient based on old gradient - C'(t). Then run that through fitness_measure.m
- fitness_measure.m - takes the fitted normal distribution from the sampling line and shoves it in an equation and pops out a value.
- min_efit.m - minimizes the e_fit value given a sampling line. returns the optimized t1/t2 values.
- e_sm.m - part of that energy minimization function. Unused in the code as is, but it's still included.
- getSample - given a sampleset and the pixel values, return the t values in relation to that set and the pixel values at that set.
- shadowgradtransf.m - gets the shadow gradient transfer function. Plug in values, get values in return. Fairly simple.
- getLSGradients.m - gets the gradients of light and umbra areas around the rough penumbra area. For normal calculations.

The images we used are straight out of the paper. I kinda just took screenshots off it.

The code is a little slow. It may take a few minutes to work, but it’ll return things.
