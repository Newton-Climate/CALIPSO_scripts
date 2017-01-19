files = dir('*.hdf');
element = 1; vector_min = [];
for file = files'
    
    [data , lon , lat] = hdfeos2(file.name);
    data = bitand(data, 7);
    lims = [1 20];
    data = data';
    lon = lon'; lat = lat';
    
    % Convert the first row of data and convert to a block (block variable is automatically created)
    [block,TypeText] = vfm_row2block(data(lims(1),:),'type');
    % Convert the rest of the rows to block and append
    for i =lims(1)+1:lims(2),
        block=cat(2,block,vfm_row2block(data(i,:),'type'));
    end
    vector_min(element) = min(sum(block));
    element = element + 1;
end
vector_min


