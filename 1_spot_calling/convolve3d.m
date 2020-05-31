% convolve image with a psf

function convolvedimg = convolve3d(origImg,psf)


%inputpsf = double(psf);
imgsize = size(origImg);
psfsize = size(psf);

if sum( psfsize > imgsize ) >= 1
    
    % psf is larger than the image
    
    %calculate pad size
       
    padsize = zeros(1,3);
    
    difvec = psfsize-imgsize;
    
    padamountidx = find(difvec>0);
    padsize(padamountidx) = ceil(difvec(padamountidx)/2);
      
    paddedimg = padarray(origImg,padsize,0); % pad with zero
    
    imgsize = size(paddedimg);
    
    convolvedimg = ifftn(fftn(paddedimg).*psf2otf(psf,imgsize));
    
    % then return to its original size
    
    convolvedimg = convolvedimg(padsize(1)+1:end-padsize(1),...
                                padsize(2)+1:end-padsize(2),...
                                padsize(3)+1:end-padsize(3));

else
    
    convolvedimg = ifftn(fftn(origImg).*psf2otf(psf,imgsize));
    
end


end