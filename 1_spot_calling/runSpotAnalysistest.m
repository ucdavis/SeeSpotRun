%%%%JM commented out the figures that the function makes to decrease
%%%%computation time.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script will be used to analyze individual cells spot location
% in a 3D timelapse (4D volume images)
% Don't forget to first load the whole timelapse using open4dtiff program
% followed by running crop4Dvol to extract the timelapse of one cell
% Peak localization is performed through local minima detection by 3x3x3
% 3D-dilation operation followed by a curvature measurement by which the true peaks are
% selected. This is then followed by a mixture-model 3D gaussian fitting
% using a Non-Linear Least Square technique
%
%
% April 8, 2010 D.E. - Burgess Lab '2010
%
% History/Upgrade/Modifications:
% - 07/12/2010. D.E.
%   I've consolidated all of the subfunctions into one file so that 
%   this program itself is sufficient to run the program
%   The subfunctions are:
%   - curvature3D ( calculates the curvature Values )
%   - determinant3D ( calculates the determinant of a Hessian Matrix ) 
%   - findpeaks3D ( finds the local maxima by image dilation )
%   - cropCubes ( isolates each local maxima by a bounding box, by default
%   5x5x5 box)
%   - gradient3 ( calculates partial derivative of a 3d matrix using finite
%   differences)
%   - subResfit2 ( fitting multiple Gaussian kernel to refine positional
%   data to subresolution accuracy using Least-Squares method )
%
% - 07/15/2010 D.E.
%   I've consolidated subresolution fitting into this one to seamlessly integrate this
%   function. It's often confusing to have a separate step, so now users
%   can specify whether they want to refine the position with Gaussian
%   fitting or not. The program now generates two outputs: spot coordinates
%   into pkcollect, and the kymograph between two spots
% - 07/17/2010 D.E.
%   I've changed the way peak selection is performed. I followed the
%   original paper in constructing a cumulative histogram/rank plot and then
%   selecting a threshold based on 1/(s_value(k+1)+s_value(k)) criteria given by the
%   user. This value by default is -1.5e-09, but can be relaxed by
%   decreasing it (e.g. -1.8e-09, -2.0e-09 ) or made more stringent by
%   increasing it (e.g. -1e-09). Changing the order of magnitude isn't
%   recommended (at least for our dataset, which has low signal-to-ratio). 
% - 07/18/2010 D.E.
%   In light of the difference between confocal and widefield data, I've
%   decided to, again, change the way threshold is applied. This time, the
%   user may choose to specify the orders of magnitude by which the
%   curvature values differ between a real spot versus a noise peak. I
%   routinely see the values differ in two orders of magnitude (10^2 = 100)
%
%   I've also included padding by mean value of the image by 5 pixel
%   border. Doing this salvages truncated data from spots that becomes out
%   of capture window during imaging.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [pkcollect,kymograph,distdata] = runSpotAnalysistest(varargin)
% for really dim spot is 1.63580
orderOfMag = 1.3;    % This is the relaxation number for peak thresholding.
                       % lower is less relaxed, higher is more relaxed
    switch nargin
        
        case 3
        
        analyzeMe = varargin{1};
        noiseblock = varargin{2};
        method = varargin{3};
        gfitoption = 'dont_fit_me';
        conflimit = 0;
       
        case 4
        
        analyzeMe = varargin{1};
        noiseblock = varargin{2};
        method = varargin{3};
        gfitoption = varargin{4};
        conflimit = 0.95;
        
        case 5
       
        analyzeMe = varargin{1};
        noiseblock = varargin{2};
        method = varargin{3};
        gfitoption = varargin{4};
        conflimit = varargin{5};
        
    end
    
% check whether image is 8-bit, 16-bit or 32-bit

dummy = whos('analyzeMe');
datatype = dummy.class;

    switch datatype 
    
    case 'uint8'
        % Perform padding with mean values to accomodate for truncated spots
        % pad by 5 pixels

        analyzeMe = padarray(analyzeMe,[5 5 5 0], uint8(mean(analyzeMe(:))));
        
    case 'uint16'
        
        analyzeMe = padarray(analyzeMe,[5 5 5 0], uint16(mean(analyzeMe(:))));
        
    case 'uint32' % currently fftn of 32-bit data isn't supported, convert to 16bit
        
        analyzeMe = uint16(analyzeMe);
        analyzeMe = padarray(analyzeMe,[5 5 5 0], uint16(mean(analyzeMe(:))));
        
    case 'double'
        analyzeMe = padarray(analyzeMe,[5 5 5 0], mean(analyzeMe(:)));
        
    end

if ndims(analyzeMe)>3 % is it a 4D image
   numTimepoints = size(analyzeMe,4);
elseif ndims(analyzeMe)<=3    % or is it a 3D image
   numTimepoints = 1;
end

thresval = zeros(numTimepoints,2);

pkcollect = cell(numTimepoints,1);

cuttingbox = [5 5 5]; % this is the cube size that cuts out around the spot in [x y z]

for tp = 1:numTimepoints,
        
    noisetp = noiseblock(:,:,:,tp); %obtain noise volume image for this timepoint
    bgAmp = mean(double(noisetp(:))); %get mean value as your background
   
    workimg = analyzeMe(:,:,:,tp);

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % You can change this parameter according to your imaging parameters
    % gauss3Dpsf consists of these inputs (in order) :
    % 1st Input => N.A. of objective lens
    % 2nd Input => Excitation Wavelength (e.g. GFP is about 520 nanometers)
    % 3rd Input => Pixel size in XY (e.g. 0.133micron/pixel in our 100x magnification)
    % 4th Input => Pixel size in Z (e.g. the Z-interval distance)
    smoothed = convolve3d(workimg,gauss3Dpsf(1.46,.528,.133,0.250)); %you can change this if you want (or if appropriate)
    %smoothed = workimg;
    % These parameters are used to reduce random noise by applying 'a
    % priori' resolution limit that can be approximated by a gaussian
    % As a result, it reveals true peaks locations for easier
    % identification using the local maxima method (done below) 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    pklocs = findpeaks3D(smoothed); % obtain local maxima from convolved image 
    
    curvature_values = curvature3D(smoothed,pklocs,cuttingbox); %calculate curvature
    
    %calculate criteria for thresholding which is curvature*mean intensity
    %value according to thomann et al. 2002
    s_values = curvature_values(:,1).*curvature_values(:,2);

% This portion of the program is for displaying the plots and images

    %JMxymax = max(smoothed,[],3); %make xy projection
    %JMxzmax = squeeze(max(smoothed,[],1))'; %make xz projection
    %JMyzmax = squeeze(max(smoothed,[],2))'; %make yz projection
    %JMsubplot(2,3,1), imagesc(xymax), colormap('hot'), axis('image','xy','off'),title('XY view'),...
%            hold on, 
%                 for pknum = 1:length(pklocs.posx) 
%                     text(pklocs.posx(pknum),pklocs.posy(pknum),num2str(pknum),'Color','b')
%                 end
%             hold off;
    %JMsubplot(2,3,2), imagesc(xzmax), colormap('hot'), axis('image','xy','off'),title('XZ view'),...
%             hold on,
%                 for pknum = 1:length(pklocs.posx)
%                      text(pklocs.posx(pknum),pklocs.posz(pknum),num2str(pknum),'Color','b')
%                 end
%             hold off;
    %JMsubplot(2,3,3), imagesc(yzmax), colormap('hot'), axis('image','xy','off'),title('YZ view'),...
%             hold on,
%                 for pknum = 1:length(pklocs.posy)
%                      text(pklocs.posy(pknum),pklocs.posz(pknum),num2str(pknum),'Color','b')
%                 end
%             hold off;
    % Plot your measurement data
    %subplot(2,3,4:6), hold on, plot([0 length(s_values)],[tVal tVal],'r--'), hold off;

    
    %update plot for every mouse movement to show cutoff line
    %f = findobj(dataSelectionPlot,'Type','Axes');
    %set(gcf,'WindowButtonMotionFcn',@(obj,event)cursorLocation(obj,event,'BottomLeft','X: %.3f\nY: %.3f','r'));
    
    % halt everything until you get a mouse click to determine threshold
%     % value

if strcmpi(method,'manual')
    
     
    subplot(2,3,4:6); stem(s_values),ylim([min(s_values(:)) 0]), title(['Curvature Measurement. Timepoint : ' num2str(tp) '.']), xlim([0 length(s_values)]);
    drawnow;
    
    thresval(tp,:) = ginput(1);
    thresFilt = thresval(tp,2); 
    
    tVal = thresFilt; %User set threshold by interactive thresholding
    
    truepkIDX = find(s_values<=tVal);
    
    
    % finalpklocs contains the final local maxima positions for one time
    % point only
    
    finalpklocs = struct('posx',pklocs.posx(truepkIDX),...
                         'posy',pklocs.posy(truepkIDX),...
                         'posz',pklocs.posz(truepkIDX),...
                         'amp',pklocs.amp(truepkIDX),...
                         'bgval',bgAmp);
                                          
                     
    pkcollect{tp,1} = finalpklocs;
    
elseif strcmpi(method,'auto')
        
    %sorted = sort(s_values,'descend');
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Change tval to alter threshold value (obsolete)
    % tval is set in two separate levels
    %   First one is the MEDIAN - constant1*STANDARD_DEVIATION
    %   Second one is the constant2*tval
    %   constant1 can be in the range of 1.5 ~ 3.0; Higher being more stringent
    %   constant2 can be in the range of 0 ~ 1; Higher being more stringent
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     tVal = median(s_values)-1.75*std(s_values);
%     tVal = 0.45*tVal;
%   
%     

%     % Cumulative Histogram thresholding method
      % With the knowledge that the spot response number (curvature values)
      % of a real spot versus noise is at least two orders of magnitude
      % (100-fold), we can define threshold of the slope of the cumulative
      % histogram so that users no long have to input this value.
      % I propose to just have this value for user input: orders of
      % magnitude difference and this number can be a floating number.
      % I'd take the threshold as 1./(max(s_value)-(max(s_value)/100))
    
    A = sort(s_values(:)); % sort the curvature values in a ascending order
    B = (A(1:end) - [A(2:end); NaN]); % get the differences s^(k+1)-s^(k) the slope
    
    Btval = (min(B)/10^orderOfMag);
   
    if length(B)~=2
        
        tempidx = find(B<Btval);
        
    elseif length(B)==2 || length(B)==1
        
        tempidx = 1:length(B); %If there are only two spots, or one, they must
        %be real assuming your don't have blank data set.
        
    end
    
    %find minima in the slope plot; this is the most significant drop in
    %s-values
    if length(A)>1  %if there's more than one peak,
    
        tVal = A(tempidx(end)); %
    
    elseif length(A)==1 % or if there's only one peak, choose it
        
        tVal = A;
        
    end
%     
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %JMsubplot(2,3,4:6); stem(s_values),...
         %JMylim([min(s_values(:)) 0]), ...
        %JMtitle(['Curvature Measurement. Timepoint : ' num2str(tp) '.']), xlim([0 length(s_values)]);
   
    %JMsubplot(2,3,4:6), hold on, plot([0 length(s_values)],[tVal tVal],'r--'), hold off;
    
    %JMdrawnow;
    
    truepkIDX = find(s_values<=tVal);
    
    
    % finalpklocs contains the final local maxima positions for one time
    % point only
    
    finalpklocs = struct('posx',pklocs.posx(truepkIDX),...
                         'posy',pklocs.posy(truepkIDX),...
                         'posz',pklocs.posz(truepkIDX),...
                         'amp',pklocs.amp(truepkIDX),...
                         'bgval',bgAmp);
                                          
                     
    pkcollect{tp,1} = finalpklocs;
    
    
end
  

    
end

if strcmpi(gfitoption,'gaussian') 

    pkcollect = subResfit2(analyzeMe,pkcollect,conflimit,cuttingbox);

end


[kymograph,distdata] = improfile3D(analyzeMe,pkcollect);

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Subfunction #1 
% calculate 3D curvature according to Thomann et al. 2002

function curvatureValue = curvature3D(imgdata, pklocs, cuttingbox)

% obtain the localized maxima in a cube
imgdata=double(imgdata);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You can change the window size. However, just be cautious of peaks that
% are on the edge because they have truncated data. [5 5 5] works best for
% yeast fluorescent spots with pixel size 0.0645 - 0.133 micron and Z
% spacing 0.2 - 0.4 micron
windowsize = cuttingbox; % this is your bounding box size in 3D [y x z];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cloc = ((windowsize-1)/2) + 1; %center location in [x y z]

cropcube = cropCubes(imgdata,pklocs,windowsize);

cropnum = size(pklocs.amp,1);

curvatureValue = zeros(cropnum,2);


    for cn = 1:cropnum,
        %normalize intensity values so that integral of F(x,y,z) = 1
        cropcube{cn} = double(cropcube{cn});                      
        curvatureValue(cn,1) = determinant3D(cropcube{cn}, cloc); % curvature measurement 
        curvatureValue(cn,2) = mean(mean(mean(cropcube{cn}))); % mean intensity value
   
    end
   
    

    clearvars cropcube;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Subfunction #2
% 

%Calculate 3D hessian matrix

function curvatureValue = determinant3D(volimg, cloc)

img = double(volimg);

Dx = gradient3(img,'x');
Dxx = gradient3(Dx,'x');
Dxy = gradient3(Dx,'y');
Dxz = gradient3(Dx,'z');

Dy = gradient3(img,'y');
Dyx = gradient3(Dy,'x');
Dyy = gradient3(Dy,'y');
Dyz = gradient3(Dy,'z');

Dz = gradient3(img,'z');
Dzx = gradient3(Dz,'x');
Dzy = gradient3(Dz,'y');
Dzz = gradient3(Dz,'z');

clearvars Dx Dy Dz;

hessianMatrix = [Dxx(cloc(1),cloc(2),cloc(3)) Dxy(cloc(1),cloc(2),cloc(3)) Dxz(cloc(1),cloc(2),cloc(3));...
                 Dyx(cloc(1),cloc(2),cloc(3)) Dyy(cloc(1),cloc(2),cloc(3)) Dyz(cloc(1),cloc(2),cloc(3));...
                 Dzx(cloc(1),cloc(2),cloc(3)) Dzy(cloc(1),cloc(2),cloc(3)) Dzz(cloc(1),cloc(2),cloc(3));];
             
curvatureValue = det(hessianMatrix);


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Subfunction #3

% This functions finds local maxima in 3D by using image dilation

function pkdata = findpeaks3D(origImg) 
    
    %edgepadsize = 2;

    workImg = double(origImg);
    sz = size(workImg);
    
    dilatedImg = imdilate(workImg,ones(3,3,3)); %dilate grayscale image by 3x3x3 window
    
    workImg(workImg==0) = NaN;
    dilatedImg(dilatedImg==0) = NaN;
    
    pkLocs = (workImg==dilatedImg);
    
    %Black out borders to clear false maxima
    %{
    pkLocs(1:edgepadsize,:,:) = zeros([edgepadsize sz(2) sz(3)]);
    pkLocs(:,1:edgepadsize,:) = zeros([sz(1) edgepadsize sz(3)]);
    pkLocs(:,:,1:edgepadsize) = zeros([sz(1) sz(2) edgepadsize]);
    
    pkLocs(sz(1)-(edgepadsize-1):sz(1),:,:) = zeros([edgepadsize sz(2) sz(3)]);
    pkLocs(:,sz(2)-(edgepadsize-1):sz(2),:) = zeros([sz(1) edgepadsize sz(3)]);
    pkLocs(:,:,sz(3)-(edgepadsize-1):sz(3)) = zeros([sz(1) sz(2) edgepadsize]);
    %}
    %pkfound = pkLocs.*workImg;
    
    pkidx = find(pkLocs==1);
    %numpkfound = length(pkidx);
    
    
    [posy,posx,posz] = ind2sub(sz,pkidx);
    
    
%         intVals = zeros(numpkfound,1);
    intVals = workImg(pkidx);   
    
    ampCutoff = mean(intVals) + 2.5*std(intVals);
       
    cutoffidx = find(intVals>ampCutoff);
    
    pkdata = struct('posx',posx(cutoffidx),'posy',posy(cutoffidx),'posz',posz(cutoffidx),'amp',intVals(cutoffidx));

    clearvars workImg dilatedImg;
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Subfunction #4
% Crop local maxima to a box
% pklocs is in pkloc struct data set from findpeaks3D
% 
% modification: 06/08/2010; added variable to specify cube size
% cubesize: X-Y-Z e.g. [x y z]. 

function cropimg = cropCubes(origImg,pklocs,cubesize)

numpeaks = size(pklocs.amp,1);
cropimg = cell(numpeaks,1);


offsetx = (cubesize(1)-1)/2;
offsety = (cubesize(2)-1)/2;
offsetz = (cubesize(3)-1)/2;

    for cn = 1:numpeaks
        
       cropimg{cn} = origImg(...
            pklocs.posy(cn)-offsetx:pklocs.posy(cn)+offsetx, ... 
            pklocs.posx(cn)-offsety:pklocs.posx(cn)+offsety, ...
            pklocs.posz(cn)-offsetz:pklocs.posz(cn)+offsetz);

    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Subfunction #5
% Partial derivative calculation of a 3D matrix using finite differences 

% Calculate derivative or image gradient with respect to specified
% dimensions
% Input must be 3-D matrix

function D = gradient3(origImg_3d_matrix,dimension)

I = double(origImg_3d_matrix);
[y,x,z] = size(origImg_3d_matrix);

    switch lower(dimension)

        case 'x'

          D(:,1,:) = I(:,2,:) - I(:,1,:);
          D(:,x,:) = I(:,x,:) - I(:,x-1,:);
          D(:,2:x-1,:) = (I(:,3:x,:) - I(:,1:x-2,:))/2; 

        case 'y'

          D(1,:,:) = I(2,:,:) - I(1,:,:);
          D(y,:,:) = I(y,:,:) - I(y-1,:,:);
          D(2:y-1,:,:) = (I(3:y,:,:) - I(1:y-2,:,:))/2;

        case 'z'

          D(:,:,1) = I(:,:,2) - I(:,:,1);
          D(:,:,z) = I(:,:,z) - I(:,:,z-1);
          D(:,:,2:z-1) = (I(:,:,3:z) - I(:,:,1:z-2))/2;


    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Subfunction #6
% This program will perform multiple gaussian kernel 
%
%
% Version 2 (now performs fitting for every spot with increasing kernels)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function subResPklocs = subResfit2(rawCroppedImg, finpklocs, conflimit, cutBox)

numtp = numel(finpklocs); %get how many timepoints
subResPklocs = cell(numtp,1); %pre-allocate array
%set the variance of 3D-Gaussian to be fitted to data
%See: 'Obtain3DGaussfit' function to obtain these values experimentally

NA = 1.46;
refidx = 1.518; % refractive index of your immersion oil/medium
lambda = 0.528; % wavelength of emission light
pixXY = 0.133; % pixel size in XY (in microns)
pixZ = 0.250; % pixel size in Z (in microns)

sigmaXY = (0.21*(lambda/NA))/pixXY;
sigmaZ = (0.66*(lambda*refidx/NA^2))/pixZ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plug-in the values you get from obtain3DGaussfit
% into here
% the first column of obtain3DGaussfit result is your sigmaXY
% the second column of obtain3DGaussfit result is your sigmaZ
% sigmaXY = 0.89;
% sigmaZ = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is the confidence interval by which you test 
% the goodness-of-fit fo your model
% Specifically, this is used to determined how many Gaussians
% are added to your spot. The lower the confidence, the more Gaussians 
% you will fit into your spot. 
% I strongly suggest using 95 percent, but this can be lowered down to 
% about 70%-80%. Just be sure to visually validate the assignment.
% I have not done any testing with better-sampled data (using DeltaVision
% or any normal CCD that typically has smaller pixel size than an EM-CCD)
% but I would predict that this works best on well-sampled data.

confidenceLimit = conflimit; 

cuttingbox = cutBox; % This is the size of your box that contains your spot (in pixel)

centerloc = ((cuttingbox-1)/2) + 1; % Initial centers of the spot

%fitting option
options = optimset('display','off','TolFun',1e-14,'TolX',1e-6,'Jacobian','on','LargeScale','on');
progressText(0,'Initializing..'); %Initialize progress indicator

       for tp = 1:numtp %for each time point perform these operations
            
            progressText(tp/numtp,'Fitting Gaussian...');
                        
            workImg = double(rawCroppedImg(:,:,:,tp)); %subtract background 
           
            locMaxima = cropCubes(workImg, finpklocs{tp}, cuttingbox); %isolate each maxima      
                                    
            %Detect the number of peaks found
            numOfMaxima = length(finpklocs{tp}.amp);
            
            if numOfMaxima <= 10 %Limit to only 5 spots maximum! 
                
                for maxnum = 1:numOfMaxima % for every local maxima found
                    
                    nkernel = 1; %begin with just one Gaussian kernel
                    kernel_limit = 5; % maximum numbers of Gaussian kernel to be fitted per spot
%                   
                    while nkernel <= kernel_limit %Initiate while loop 
                    
                    %Define upper and lower boundaries for fitting
                    %parameters
                    %-----------------------------------------------------
                    %Amplitude lower limit is half of the measured
                    %intensity value.
                    %Amplitude upper limit is 1.5x of the measured
                    %intensity value
                    
%                    amp_lowerlim = repmat(finpklocs{tp}.bgval,1,nkernel); %Lowest intensity must be greater than background
%                    amp_upperlim = repmat(finpklocs{tp}.amp(maxnum)*4,1,nkernel);
                   
                    % limits will be defined [Amp(1,1:n) x(1,1:n) y(1,1:n) z(1,1:n) background];
                    % n is the number of kernels to be fitted to data
                    % fit limit is 2*sigmaXY and 2*sigmaZ to constrain
                    % fit to nearby psfs
                    llimxy = repmat(3 - (2*sigmaXY),1,nkernel);
                    ulimxy = repmat(3 + (2*sigmaXY),1,nkernel);
                    llimz = repmat(3 - (2*sigmaZ),1,nkernel);
                    ulimz = repmat(3 + (2*sigmaZ),1,nkernel);
                
                    initparam = [repmat(finpklocs{tp}.amp(maxnum)-finpklocs{tp}.bgval,1,nkernel)/nkernel ... %intensity-background
                                 repmat(centerloc(1),1,nkernel) repmat(centerloc(2),1,nkernel) repmat(centerloc(3),1,nkernel)... %initial guess at the center of the 5x5x5 cube
                                 finpklocs{tp}.bgval]; %Initial guess of background
%                   
%                 
% 
                    lb = [0 llimxy llimxy llimz 0];
                    ub = [Inf ulimxy ulimxy ulimz Inf];
%                     lb = [];
%                     ub = [];
                    %Perform non-linear least square fitting procedure and
                    %Recover fitted parameters in acpar
                    %resnorm -> normalized residuals
                    %resid -> actual residual from calculated-realdata
                    [acpar,resnorm,resid] = lsqnonlin(@fit3DGaussian,initparam,lb,ub,options,locMaxima{maxnum},sigmaXY,sigmaZ);
                    
                    bgValonly = acpar(end);
                    acpar_minusbg = acpar(1:end-1);
                    
                    % Sort parameters such that
                    % sortedParameters(1,1:4) = [Amplitude1 X1 Y1 Z1];
                    % sortedParameters(2,1:4) = [Amplitude2 X2 Y2 Z2];
                    % sortedParameters(3,1:4) = [Amplitude3 X3 Y3 Z3]; and
                    % so on....
                    
                    sortedParameters = reshape(acpar_minusbg,nkernel,4);
                    sortedParameters(:,1) = sortedParameters(:,1);
                
                    
                    chiSquare(nkernel,1) = sum(resid.^2)/((numel(locMaxima{maxnum})-(4*nkernel+1))); %Calculate Chi-Square value for each n-kernel fit
                    %disp(['Resnorm : ' num2str(resnorm) '.']);
                        if nkernel >= 2 %once more than two kernels have been reached

                            %calculate the Chi-Square ratio
                            %determine whether to continue adding kernel by
                            %setting T value based on Chi-Square ratio between
                            % X^2(previous-n-kernel)/X^2(current-n-kernel)
                            % if X^2(current-n-kernel) is small, indicating
                            % smaller error, then T should be bigger than one,
                            % then continue adding kernel until you reach a
                            % number that introduces error (in a sense: a
                            % best-fitting scenario)
                            
                            T = chiSquare(nkernel-1,1)/chiSquare(nkernel,1);
                            
                            confidence = fcdf(T,(4*(nkernel-1)+1),(4*nkernel+1)); % T is F-distributed
                            %display(['Kernel #: ' num2str(nkernel) '. T : ' num2str(confidence) '.']);
                            if confidence <= confidenceLimit %if confidence level is reached
                                
                                %erase the last fit values so they don't
                                %get used
                                sortedParameters(nkernel,:) = [];
                                
                                break; %get out of the while loop
                            end
                            
                        end
                    
                    nkernel = nkernel + 1; %Add the kernel number
                                   
                    
                    end
                    
                    recoveredPeaks{maxnum} = struct('amp',sortedParameters(:,1),...
                                                   'posx',finpklocs{tp}.posx(maxnum)-(3-sortedParameters(:,2)),...
                                                   'posy',finpklocs{tp}.posy(maxnum)-(3-sortedParameters(:,3)),...
                                                   'posz',finpklocs{tp}.posz(maxnum)-(3-sortedParameters(:,4)),...
                                                   'bgval',bgValonly);
                    
                end
                   
                tempStore = [recoveredPeaks{:}]; %convert cell to struct with same fields
                clear recoveredPeaks;
                subResPklocs{tp} = struct('amp',cat(1,tempStore(:).amp),...
                                         'posx',cat(1,tempStore(:).posx),...
                                         'posy',cat(1,tempStore(:).posy),...
                                         'posz',cat(1,tempStore(:).posz),...
                                         'bgval',cat(1,tempStore(:).bgval));
                clear tempStore;
                
            else
                
               subResPklocs{tp} = struct('amp',NaN,...
                                         'posx',NaN,...
                                         'posy',NaN,...
                                         'posz',NaN,...
                                         'bgval',NaN);
                
            end
                
        end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A subfunction that is required for above function "subResfit2.m"
% 3D gaussian fit with jacobian supplied for recovering parameters
% to be used with subRes_fit_standAlone
% needs another function written as create3Dgauss.m to generate gaussian 

function [F,J] = fit3DGaussian(initparams, rawdata, varXY, varZ)

rawsz = size(rawdata);
numpix = prod(rawsz);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% initparams must be arranged such that each initial estimate is grouped
% together.
% The last column is designated for background value estimate
% initparams = [Amp1 Amp2 Amp3 X1 X2 X3 Y1 Y2 Y3 Z1 Z2 Z3 bgAmp];
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


bgonly = initparams(end); %get Background value only

fitparams = initparams(1:end-1);

% Since we're only solving for 4 free-parameters per gaussian

nkernels = length(fitparams)/4;

% re-arrange initparams so that MxN -> nkernelx4 (row x column)

initparams = reshape(fitparams,nkernels,4);

[X,Y,Z] = meshgrid(1:rawsz(2),1:rawsz(1),1:rawsz(3));

calcX = zeros(numpix,nkernels);
calcY = zeros(numpix,nkernels);
calcZ = zeros(numpix,nkernels);


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%  This is the fitting paramater that needs to be determine depending on
%  which sample you're trying to measure (100x vs. 150x has different sigma
%  values. Different Z-steps will also cause the sigma values to be
%  different due to different sampling rate affecting the PSF measurement.
%  To solve for sigma, you need to empirically measure one spot's sigmas or
%  even better, you can average multiple sigmas from several beads/spots

% sigmaXY = 1.0629; %make sure this is consistent with fitting function (subResfit_standAlone)
% sigmaZ = 1.3308;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


 AmpVals = repmat(initparams(:,1)',numpix,1); % re-arrange for multiplication
 
 BGvals = repmat(bgonly,numpix,1); 

 tempjac = cell(nkernels,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initparams(1) = amplitude
% initparams(2) = x mean location
% initparams(3) = y mean location
% initparams(4) = z mean location
% initparams(5) = backgroundValue
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for nk = 1:nkernels

        calcX(:,nk) = exp(-0.5*( ((X(:)-initparams(nk,2)).^2)/varXY^2));
        calcY(:,nk) = exp(-0.5*( ((Y(:)-initparams(nk,3)).^2)/varXY^2));
        calcZ(:,nk) = exp(-0.5*( ((Z(:)-initparams(nk,4)).^2)/varZ^2));
        
             
%         tempjac{nk,1} = [ampCol(X(:),initparams(nk,2),Y(:),initparams(nk,3),Z(:),initparams(nk,4),sigmaXY,sigmaZ),...
%                          wrtX(initparams(nk,1),X(:),initparams(nk,2),Y(:),initparams(nk,3),Z(:),initparams(nk,4),sigmaXY,sigmaZ),...
%                          wrtY(initparams(nk,1),X(:),initparams(nk,2),Y(:),initparams(nk,3),Z(:),initparams(nk,4),sigmaXY,sigmaZ),...
%                          wrtZ(initparams(nk,1),X(:),initparams(nk,2),Y(:),initparams(nk,3),Z(:),initparams(nk,4),sigmaXY,sigmaZ),...
%                         ];
% 
%         ampDiff = exp( ((initparams(nk,2)-X(:)).^2/(2*varXY^2)) + ...
%                        ((initparams(nk,3)-Y(:)).^2/(2*varXY^2)) + ...
%                        ((initparams(nk,4)-Z(:)).^2/(2*varZ^2))); % needed to simplify jacobian
%         
                         
            psi = exp(-0.5*( ( (initparams(nk,2)-X(:)).^2/varXY^2 ) + ...
                             ( (initparams(nk,3)-Y(:)).^2/varXY^2 ) + ...
                             ( (initparams(nk,4)-Z(:)).^2/varZ^2 )));
    
            tempjac{nk,1} = [  psi,...      %gradient w.r.t amplitude
                             (-initparams(nk,1)*(initparams(nk,2)-X(:))/varXY^2).*psi,... %gradient w.r.t x
                             (-initparams(nk,1)*(initparams(nk,3)-Y(:))/varXY^2).*psi,... %gradient w.r.t y
                             (-initparams(nk,1)*(initparams(nk,4)-Z(:))/varZ^2).*psi];    %gradient w.r.t z
                         
                    
    end

    F = (sum(AmpVals.*calcX.*calcY.*calcZ,2)+BGvals)-double(rawdata(:));

    % compile the jacobian
    J = ones(numpix,4*nkernels+1); %last column for Background value
    Jtemp = cat(1,tempjac{:});
    Jtemp = reshape(Jtemp,numpix,4*nkernels);
    J(:,1:end-1) = Jtemp;
   
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates interpolated 3-D kymograph
% given two points in 3-D space and a 3D volume image
%
% Think about it as a 3-dimensional improfile function
%
% Daniel Elnatan (Burgess Lab)
% History/Updates:
%
% 5/17/2010
% fixed for same XY , X , and Y coordinates. -D.E.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [intensityProfile3D,distanceData] = improfile3D(crop4d_image,pklocs)

numtp = size(crop4d_image,4);
pixel_spacing = -20:1:20; %final result has width of 41 pixels; you can change this if needed
intensityProfile3D = zeros(numtp,length(pixel_spacing)); %pre-allocate with zeros
distanceData = zeros(numtp,1);

pixelSizeXY = 0.133; % in micron
pixelSizeZ = 0.250; % in micron

for tp = 1:numtp,
    %disp(['Working on timepoint : ' num2str(tp) '.']);
    if isempty(pklocs{tp}) %if no peaks are detected, skip to the next one; assign zeros
        
    continue;
        
    elseif length(pklocs{tp}.posx)>2
        
        distanceData(tp,1) = NaN;
        
    elseif length(pklocs{tp}.posx)==2,

        pointA = [pklocs{tp}.posx(1) pklocs{tp}.posy(1) pklocs{tp}.posz(1)];
        pointB = [pklocs{tp}.posx(2) pklocs{tp}.posy(2) pklocs{tp}.posz(2)];
       
        %calculate distance between spots
        distanceData(tp,1) = sqrt(...
                                    ((pointA(1)-pointB(1))*pixelSizeXY)^2+...
                                    ((pointA(2)-pointB(2))*pixelSizeXY)^2+...
                                    ((pointA(3)-pointB(3))*pixelSizeZ)^2);
        
        %calculate middle point
        middlepoint = (pointA+pointB)/2;
        
        normPointsA = [pointA(1)-middlepoint(1), pointA(2)-middlepoint(2), pointA(3)-middlepoint(3)];
        normPointsB = [pointB(1)-middlepoint(1), pointB(2)-middlepoint(2), pointB(3)-middlepoint(3)];
        
        upthetaA = acos(normPointsA(3)/(normPointsA(1)^2+normPointsA(2)^2+normPointsA(3)^2));
        flataziA = atan2(normPointsA(2),normPointsA(1));
        
        
        upthetaB = acos(normPointsB(3)/(normPointsB(1)^2+normPointsB(2)^2+normPointsB(3)^2));
        flataziB = atan2(normPointsB(2),normPointsB(1));
       
         %first calculate the slope vector for 3D line equation

         lineVec = pointB-pointA;
 
         %calculate distance between two points in pixels
         dist3d = sqrt(sum(abs(lineVec).^2));
         
         %calculate xy-hypotenuse
         xy_hyp = sqrt(lineVec(1)^2+lineVec(2)^2);
         %calculate up-angle
         theta_up = acos(xy_hyp/dist3d);
         %calculate flat-angle
         theta_flat = acos(lineVec(1)/xy_hyp);
         
         %calculate hypotenuse of the yet unknown delta x & delta y
         small_hyp = cos(theta_up);
         
         delta_X = small_hyp*cos(theta_flat); 
         delta_Y = small_hyp*sin(theta_flat);
         delta_Z = sin(theta_up);     
         
                 
             %if X and Y coordinates are the same
             if lineVec(1)==0 && lineVec(2)==0;
                 
             delta_X = 0;
             delta_Y = 0;
             delta_Z = 1;
             
             %if X coodinates are the same
             elseif lineVec(1)==0 && lineVec(3)==0; %if X and Z are the same
                 delta_X = 0;
                 delta_Y = 1;
                 delta_Z = 0;
                 
             elseif lineVec(2)==0 && lineVec(3)==0; %if Y and Z are the same
             
                 delta_X = 1;
                 delta_Y = 0;
                 delta_Z = 0;
                 
             elseif lineVec(1)==0; %if only X are the same
                 
             delta_X = 0;
             yz_hyp = dist3d;
             theta_up = acos(lineVec(2)/yz_hyp);
             delta_Y = cos(theta_up);
             delta_Z = sin(theta_up);
             
             
             %if Y coordinates are the same
             elseif lineVec(2)==0;
                 
             delta_Y = 0;
             xz_hyp = dist3d;
             theta_up = acos(lineVec(1)/xz_hyp);
             delta_X = cos(theta_up);
             delta_Z = sin(theta_up);
             
          
                 
             end
             
         incrementFactor = [delta_X delta_Y delta_Z]';
         % correct for slope vector directions 
         incrementFactor = abs(incrementFactor).*(lineVec'./abs(lineVec'));
         % correct for zero division resulting in NaN
         incrementFactor(isnan(incrementFactor)) = 0;
        % lineVec = lineVec'; %transpose into column to row
             
         xyzlocs = (incrementFactor*pixel_spacing)+repmat(middlepoint',1,length(pixel_spacing));

        Xi = xyzlocs(1,:);
        Yi = xyzlocs(2,:);
        Zi = xyzlocs(3,:);
        
     workimg = double(crop4d_image(:,:,:,tp));
     workimg = workimg - min(workimg(:));
        
     intensityProfile3D(tp,:) = interp3(padarray(workimg,[10 10 10]),Xi+10,Yi+10,Zi+10,'linear');

    elseif length(pklocs{tp}.posx)==1 %if there's only one peak
        
            ypos = pklocs{tp}.posy;
            xpos = pklocs{tp}.posx;
            zpos = pklocs{tp}.posz;
            
            distanceData(tp,1) = 0;
            
            if ~isnan(zpos)
            
            flatImg = crop4d_image(:,:,round(zpos),tp);
            flatImg = flatImg - min(flatImg(:));

            intensityProfile3D(tp,:) = interp2(padarray(double(flatImg),[10 10]),(xpos-(pixel_spacing))+10,repmat(ypos,1,length(pixel_spacing))+10,'linear');

            elseif isnan(zpos)
                
            intensityProfile3D(tp,:) = zeros(1,length(pixel_spacing));
                
            end
            
    end
        

   

end

end
