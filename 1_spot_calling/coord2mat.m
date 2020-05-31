% convert the coordinate position to matrix
% 06/29/2010
% Cori Cahoon & Daniel Elnatan 
% MCB Dept. UC Davis (Burgess Lab)
% This program converts Coordinate data from 'runSpotAnalysis' to 
% A matrix with 4 Columns denoting [Timepoint PositionX PositionY PositionZ]
%

function finallist = coord2mat(coordinateData)

%find out how many timepoints in our 'cell' array in coordinateData
numOfTimePoints = numel(coordinateData);

%Pre-allocate memory for our potential data
combined = cell(numOfTimePoints,1);

for tp = 1:numOfTimePoints,
   
   numOfSpots = length(coordinateData{tp}.posx);
   
   if numOfSpots <= 4
   
   timepointIndex = repmat(tp,numOfSpots,1);
   
   temporary = [coordinateData{tp}.posx coordinateData{tp}.posy coordinateData{tp}.posz];
    
   combined{tp} = [timepointIndex temporary];
    
   else
       
       timepointIndex = tp;
       temporary = [NaN NaN NaN];
       combined{tp} = [timepointIndex temporary];
       
   end
   
    
end

finallist = cat(1,combined{:});
end