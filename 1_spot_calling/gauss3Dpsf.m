%generate 3D anisotropic gaussian spot
%according to Thomann et al.
%
%This program is also compatible for generating up-sampled 3D Gaussian
%which can be used for a multi-scale decomposition using a program I've
%written called 'atrous3D' which is demonstrated by Vermolen et al.

function gauss3d_img = gauss3Dpsf(NA,wavelength,pixXY,pixZ)  
%Test separability of 3D kernel generation
%baseSize = [110 220 440];
%gauss3d_img = cell(length(numOfScale),1);
numOfScale = 1;
%baseSize = 530;

for s = 1:numOfScale,
    
 %sigmapix = 530/133; %pixel size is 133 nm
 %sigmapix = 0.21*(baseSize/1.45); % NA = 1.45
 %sigmapix = sigmapix/pixelsizeXY; %133 pixel per micron
 %this implies you're using theoretical values
     %sigmapix = 1.2586;
     %sigmaz = 1.4942;
% sigmapix = 0.7221; % confocal setting xy
% sigmaz = 0.66*(baseSize*1.33/1.45^2);
% sigmaz = sigmaz/pixelsizeZ; % pixel size is 300 nanometers
% sigmaz = 0.9095; % confocal setting xz

sigmapix = (0.21*(wavelength/NA))/pixXY;
sigmaz = (0.66*(wavelength*1.518/NA^2))/pixZ;


 end
%determine windows size by calculation as to where f(x) is 10^-2 in the
%single gaussian

%Note: real lateral sigma is really about 0.8206 according to fitting in 2D

winSizeDeterminant_lateral = sqrt(-1*(2*sigmapix^2*log(0.1)));
winSizeDeterminant_axial = sqrt(-1*(18*sigmaz^2*log(0.3)));

hsize = round(winSizeDeterminant_lateral)*2+1;
hsize_z = round(winSizeDeterminant_axial)*2+1;


%hsize = 11+4*(2^(s-1)-1); % manual determination is now obsolete 

coordInput = -(hsize-1)/2:1:(hsize-1)/2;

gaussian1d = exp(-0.5*(coordInput.^2/sigmapix^2));
gaussian1d = gaussian1d/sum(gaussian1d);

gaussian2d = conv2(gaussian1d,gaussian1d');

coordInput_z = -(hsize_z-1)/2:1:(hsize_z-1)/2;

long_axis = exp(-0.5*(coordInput_z.^2/(sigmaz)^2));
long_axis = long_axis/sum(long_axis);
long_axis = reshape(long_axis,[1 1 length(long_axis)]);

gaussian3d = convn(long_axis,gaussian2d);

gauss3d_img = gaussian3d/sum(gaussian3d(:));


end




