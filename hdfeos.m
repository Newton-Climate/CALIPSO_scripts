function [data, lon, lat] = hdfeos(FILE_NAME)

% Takes HDF Data from NASA's CALIPSO Sattilite 
% Note: This is made for the Level 2 Vertical Feature Mask
% Input: Filename
%output:
% data: An array of flags which are ints
% lat: array of doubles of latitude form the dataset
% lon: an array of doubles of longitude 




% Open the HDF4 File.

SD_id = hdfsd('start', FILE_NAME, 'rdonly');

% Read data.
datafield_name='Feature_Classification_Flags';
sds_index = hdfsd('nametoindex', SD_id, datafield_name);
sds_id = hdfsd('select',SD_id, sds_index);
[name, rank, dimsizes, data_type,nattrs, status] = hdfsd('getinfo', sds_id);
[m, n] = size(dimsizes);
[data, status] = hdfsd('readdata', sds_id, zeros(1,n), ones(1,n), dimsizes);
hdfsd('endaccess', sds_id);

% Read lat.
lat_name='Latitude';
sds_index = hdfsd('nametoindex', SD_id, lat_name);
sds_id = hdfsd('select',SD_id, sds_index);
[name, rank, dimsizes,data_type,nattrs, status] = hdfsd('getinfo', sds_id);
[m, n] = size(dimsizes);
[lat, status] = hdfsd('readdata', sds_id, zeros(1,n), ones(1,n), dimsizes);
hdfsd('endaccess', sds_id);

% Read lon.
lon_name='Longitude';
sds_index = hdfsd('nametoindex', SD_id, lon_name);
sds_id = hdfsd('select',SD_id, sds_index);
[name, rank, dimsizes,data_type,nattrs, status] = hdfsd('getinfo', sds_id);
[m, n] = size(dimsizes);
[lon, status] = hdfsd('readdata', sds_id, zeros(1,n), ones(1,n), dimsizes);
hdfsd('endaccess', sds_id);

% Close the file.
hdfsd('end', SD_id);

%taking the transpose to make it more usable as row vectors rather than column vectors
lon = lon';
lat = lat';
data = data';

%Taking the first 3 bits representing the feature type
data = bitand(data, 7);

% subsetting data by blocks separating them by resolution. Different altitudes have different resolution.
 data2d_lv3 = squeeze(data(:, 1:165));    % 20.2km to 30.1km
data2d_lv2 = squeeze(data(:, 166:1165)) %  8.2km to 20.2km
data2d_lv1 = squeeze(data(:, 1166:5515));   % -0.5km to 8.2km
data3d = reshape(data2d, dim, 290, 15);
data = squeeze(data3d(:,:,1));
