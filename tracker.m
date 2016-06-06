vr = VideoReader('carchase.mp4');
frame = readFrame(vr);
imshow(rgb2gray(ff))

%get target from imtool
disp('choose the target by cropping')
imtool;

q = getTargetModel(target);	

while( hasFrame(vr))
	nextframe = readFrame(vr,1);
	y = int16(size(frame)/2);  % central point of the frame
	while(1)
		p = getCandidateModel(nextframe, y, 10);
		
		w = getWeights(p,q,y,10);
		
		% Mean Shift
		rho = bhattacharya(p,q);
		
		newy = getNewLocation(y,w,10);
		newp = getCandidateModel(nextframe, newy, 10);
		newrho = bhattacharya(newp,q);


		while(newrho < rho)
			newy = 1/2 * (y + newy);
			newp = getCandidateModel(nextframe, newy, 10);
			newrho = bhattacharya(newp,q);
		end
		shift = abs(norm(newy - y))
		if(shift < eps)
			break;
		else	
			y = newy;
		end
	end
end