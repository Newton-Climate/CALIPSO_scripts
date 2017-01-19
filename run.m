% This script is for finding the lon and lat of clear sky in the hdf vertical feature mask file under the following assumptions:
% 1. The clear sky is denoted as 1 in the array
% 2. Each grid cell in the horizontal direction is 333 meters
%  3. The vertical resolution is varying
% 4. There are 545 vertical levels. Ideal clear vertical layer will have a sum of 545. In this case, we take the sum of each column and find the column sum closest to 545. 
	%There are caviots to this logic but this is a good first order filter.

% To run, type in "run" into the commandline on Matlab with the files that were already included in this folder
   


% Section: reading data from hdf4 file
file = 'CAL_LID_L2_VFM-ValStage1-V3-02.2012-08-18T07-58-48ZN_Subset.hdf';
[data, lon, lat] = hdfeos2(file);
data = data';
data = bitand(data, 7); %get the first 3 bits (feature type)
lims = size(lon);
lon = lon'; lat = lat';

% Section: formatting hdf data into something more readable e.g. a 2D array

% Convert the first row of data and convert to a block (block variable is automatically created)
[block,TypeText] = vfm_row2block(data(lims(1),:),'type');
% Convert the rest of the rows to block and append
for i =lims(1)+1:lims(2)
    block=cat(2,block,vfm_row2block(data(i,:),'type'));
end


%section: analyzing data from "block" 
sum_vector = sum(block);
[min_sum, min_index] = min(sum_vector);
block_index = min_index;
min_index = ceil(min_index/15);
min_lat = lat(min_index)
min_lon = lon(min_index)
mean(block(:,block_index));

disp(['The sum of the column with the minimum value e.g. closest to clear sky is ' num2str(sum_vector(block_index))]);

disp(['The latitude and longitude of clearish sky are respectively ' num2str(min_lon) ' and ' num2str(min_lat)])
