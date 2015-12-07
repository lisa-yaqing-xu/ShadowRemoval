function[] = getShadowBoundary(img,mask,brushsize)
	sampleLength = round(1.5 * brushsize);
	I = rgb2gray(img);
   	[Gmag, Gdir] = imgradient(I,'sobel');
	
	%first calculate y samples
	startCol = 1;
	startRow = 1;
	sampleLength = 0;
	sampling = false;
	direction = -1; %N,E,S,W = 0,1,2,3
	initialVal = -1;
	sampleset = {};
	for rownum=1:size(mask,1)
		%set current and last pixel values to first in the row
		lPixelVal = mask(rownum,1);
		for colnum=1:size(mask,2)
			cPixelVal = mask(rownum,colnum);
			if cPixelVal ~= lPixelVal && ~sampling
				initialVal = lPixelVal;
				if cPixelVal < lPixelVal
					direction = 2;
				else
					direction = 0;
				end
				startCol = colnum;
				startRow = rownum;
				sampleLength = sampleLength + 1;
				sampling = true;
			elseif sampling
				if cPixelVal == lPixelVal
					sampleLength = sampleLength + 1;
				else
					if sampleLength > .9 * brushsize && sampleLength < 1.5 * brushsize && initialVal ~= cPixelVal
						%add sample to sampleset
						sample = [startCol, startRow, sampleLength, direction];
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
		if sampling
			if sampleLength > .9 * brushsize && sampleLength < 1.5 * brushsize && initialVal ~= cPixelVal
				%add sample to sampleset
				sample = [startCol, startRow, sampleLength, direction];
				sampleset = [sampleset, sample];
				sampling = false;
				sampleLength = 0;
			else
				sampling = false;
				sampleLength = 0;
			end
		end

	end

	startCol = 1;
	startRow = 1;
	sampleLength = 0;
	initialVal = -1;
	direction = -1;
	sampling = false;
	for colnum=1:size(mask,2)
		%set current and last pixel values to first in the row
		lPixelVal = mask(1,colnum);
		for rownum=1:size(mask,1)
			cPixelVal = mask(rownum,colnum);
			if cPixelVal ~= lPixelVal && ~sampling
				if cPixelVal < lPixelVal
					direction = 1;
				else
					direction = 3;
				end

				startCol = colnum;
				startRow = rownum;
				sampleLength = sampleLength + 1;
				sampling = true;
			elseif sampling
				if cPixelVal == lPixelVal
					sampleLength = sampleLength + 1;
				else
					if sampleLength > .9 * brushsize && sampleLength < 1.5 * brushsize && initialVal ~=cPixelVal
						%add sample to sampleset
						sample = [startCol, startRow, sampleLength, direction];
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
		if sampling
			if sampleLength > .9 * brushsize && sampleLength < 1.5 * brushsize && initialVal ~= cPixelVal
				%add sample to sampleset
				sample = [startCol, startRow, sampleLength, direction];
				sampleset = [sampleset, sample];
				sampling = false;
				sampleLength = 0;
			else
				sampling = false;
				sampleLength = 0;
			end
		end
	end

   	%imshowpair(Gmag, Gdir, 'montage');
    
