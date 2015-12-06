function[] = getShadowBoundary(img,mask,brushsize)
	sampleLength = round(1.5 * brushsize);
	I = rgb2gray(img);
   	[Gmag, Gdir] = imgradient(I,'sobel');
	
	%first calculate y samples
	startCol = 1;
	startRow = 1;
	sampleLength = 0;
	sampling = false;
	sampleset = {};
	for rownum=1:size(mask,1)
		%set current and last pixel values to first in the row
		lPixelVal = mask(rownum,1);
		for colnum=1:size(mask,2)
			cPixelVal = mask(rownum,colnum);
			if cPixelVal ~= lPixelVal && ~sampling
				startCol = colnum;
				startRow = rownum;
				sampleLength = sampleLength + 1;
				sampling = true;
			elseif sampling
				if cPixelVal == lPixelVal
					sampleLength = sampleLength + 1;
				else
					if sampleLength > .9 * brushsize && sampleLength < 1.5 * brushsize
						%add sample to sampleset
						sample = [startCol, startRow, sampleLength];
						sampleset = [sampleset, sample];
						sampling = false;
						sampleLength = 0;
					else
						sampling = false;
						sampleLength = 0;
					end
				end
			end
			lPixelVal = cPixelVal;
		end
	end
   	%imshowpair(Gmag, Gdir, 'montage');
    
