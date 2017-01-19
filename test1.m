files = dir('*.hdf');
for file = files'
    hdf = load(file.name);
    % Do some stuff
end


[data , lon , lat] = hdfeos2('CAL_LID_L2_VFM-ValStage1-V3-01.2007-07-04T08-01-26ZN_Subset.hdf');
data = bitand(data, 7);
lims = [1 20];
data = data';
lon = lon'; lat = lat';
size(data)
% Convert the first row of data and convert to a block (block variable is automatically created)
[block,TypeText] = vfm_row2block(data(lims(1),:),'type');
% Convert the rest of the rows to block and append
for i =lims(1)+1:lims(2),
 block=cat(2,block,vfm_row2block(data(i,:),'type'));
end

size(block)
[block_row, block_col] = size(block);
tester = ones(block_row, 1);
tester = uint8(tester);
output = []; count = 1;
block_row = uint16(block_col);
for index = 1:block_col
    if uint16(sum(block(:, index))) == block_row
        output(count) = index;
    end
end
output
t = sum(block);
min(t)