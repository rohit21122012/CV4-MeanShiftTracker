function [w] = getWeights(p,q,image,y,h)

radi = int16((h-1)/2);

w = zeros((2*radi+1)*(2*radi+1),1);

bint = rgb2gray(image);

binsize = 255;
a = 1;
for i=-radi:radi
	for j=-radi:radi
		suma = 0;
		for u=1:255
			 if(y(1)+i >=1 && y(2)+j >=1 && y(1)+i <= size(bint,1) && y(2)+j <= size(bint,2)) 
                if(bint(y(1)+i,y(2)+j) == u )
					suma = suma + sqrt(p(u)/q(u));
				end
			end
		end
		w(a) = suma;
		a = a+1;
	end
end