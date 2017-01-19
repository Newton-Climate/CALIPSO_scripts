function [data, lon, lat] = hdfeos2(FILE_NAME)

% Takes HDF Data from NASA's CALIPSO Sattilite 
% Note: This is made for the Level 2 Vertical Feature Mask
% Input: Filename
%output:
% data: An array of flags which are ints
% lat: array of doubles of latitude from the dataset
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

