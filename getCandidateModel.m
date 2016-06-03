function [q] = getCandidateModel(candidate, y, h)
    %q(u) is the probability of uth feature in patch
    %choose target image by cropping 
    %imtool(ff);
    %export to a variable named target

    % creates a sparse matrix
    % for color to pixel mapping

    % try1 :  with gray scale intensity

    normalpdf = @(x) 1/2*pi *exp(-1/2 * norm((double(x))-y)/h);
   
    grayt = rgb2gray(candidate);
    bint = grayt;
    
    %mapping is already having the index value (no histogram needed)
    binsize = 255;
   
    q = zeros(binsize,1);
    radi = int16((h-1)/2)
    
    for u = 1:binsize
        suma = 0;
        for i = -radi:radi
            for j = -radi:radi
             %a =  mvnpdf([i,j], 0,[1 0; 0 1]); incorrect
             %a = norm([i,j]);      %contant kernel
             if(y(1)+i >=1 && y(2)+j >=1 && y(1)+i <= size(bint,1) && y(2)+j <= size(bint,2))
                 a = normalpdf([y(1)+i, y(2)+j]);  %normal kernel
                 suma = suma + a;
                 if(bint(y(1)+i,y(2)+j) == u )
                    q(u) = q(u) + a;    % The kroneckerdelta step
                 end
             end
            end     
        end
        q(u) = q(u) / suma;
    end

end
