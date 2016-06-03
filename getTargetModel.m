function [q] = getTargetModel(patch)
    %q(u) is the probability of uth feature in patch
    %choose target image by cropping 
    %imtool(ff);
    %export to a variable named target

    % creates a sparse matrix
    % for color to pixel mapping

    % try1 :  with gray scale intensity

    normalpdf = @(x) 1/2*pi * exp(-1/2 * norm(x));

    grayt = rgb2gray(patch);
    bint = grayt;
    %mapping is already having the index value (no histogram needed)
    binsize = 255;
    q = zeros(binsize,1);
    for u = 1:binsize
        suma = 0;
        for i = 1:size(grayt)
            for j = 1:size(grayt)
             %a =  mvnpdf([i,j], 0,[1 0; 0 1]); incorrect
             %a = norm([i,j]);      %contant kernel
             a = normalpdf([i,j]);  %normal kernel
             suma = suma + a;
             if(bint(i,j) == u )
                q(u) = q(u) + a;    % The kroneckerdelta step
             end
            end     
        end
        q(u) = q(u) / suma;
    end

end
