
function output = filter_flags( flag_counts)

[row , column] = size(flag_counts);
output  = []; count = 1;
for i = 1:column

	  % if the data shows cloudy, aresols, stratospheric features, or no data, skip the index
	  %else append the endex to the output vector

		  
	  if flag_counts(1,i) > 0 | flag_counts(3,i) > 0 | flag_counts(4, i) > 0 | flag_counts(5 , i) > 0
continue
else
output(count) = i;
count = count+1;
end
end
