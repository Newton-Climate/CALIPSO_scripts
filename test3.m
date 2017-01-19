files = dir('*.hdf');
element = 1; vector_min = [];
numfiles = size(files); numfiles = numfiles(1);
for n = 1:numfiles
    
	  [data , lon , lat] = hdfeos2(files(n).name);
    data = bitand(data, 7);

    data = data';
    lon = lon'; lat = lat';
lims = size(lon);
    
    %' Convert the first row of data and convert to a block (block variable is automatically created)
%    [block,TypeText] = vfm_row2block(data(lims(1),:),'type');
    % Convert the rest of the rows to block and append
  %  for i =lims(1)+1:lims(2),
   %     block=cat(2,block,vfm_row2block(data(i,:),'type'));
    %end
block = vfm_row2block(data, 'type');

% create an array counting the number of feature flags.
% Feature Flag Values are below:
% 0 = no data
% 1 = clear sky
% 2 = clouds
% 3 = aeresols 
% 4 = stratopshereic features
% 5 = surface
% 6 = subsurface

    flags = vfm_counter(block);
candidates = filter_flags(flags);

% Find the file indecies with nonempty (contains clear sky) values
if isequal(candidates,[]) == false
  vector_min(element) = n;
element = element + 1;
 else
   continue
     end
     
    end

