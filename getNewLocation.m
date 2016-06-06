function [y1] = getNewLocation(y0, w,h)

	% g(x) = -f'(x)    which is also a normal 
	normalkernel = @(x) 1/2*2*pi *exp(-1/2 * norm((double(x))-y0)/h);	
   
	radi = int16((h-1)/2);

	binsize = 255;
	a = 1
	sumwnorm = 0;
	y1 = [0 0]
	for i=-radi:radi
		for j=-radi:radi
			 if(y0(1)+i >=1 && y0(2)+j >=1 && y0(1)+i <= size(bint,1) && y0(2)+j <= size(bint,2)) 
             	wnorm = w(a)*(normalpdf([y0(1)+i, y0(2)+j]);  %normal kernel
             	y1 = y1 + [i,j] * wnorm;
             	sumwnorm = sumwnorm + wnorm;
			end		
			a = a + 1;
		end
	end	
end