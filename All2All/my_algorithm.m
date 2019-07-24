function confidenceMatrix = my_algorithm(current_data,window_size,sampling_rate,amount_of_mutations,current_mutations)
% Current data are provided in NxM size if amount_of_mutations = 0. N
% corresponds to the amount of genes and M corresponds to the amount of
% datapoints max (it has to be downsampled and taken a subset out of it
% depending on window_size and sampling_rate)

% Current are provided in 1xK cells if amount_of_mutations > 0. K
% corresponds to the amount_of_mutations.

% Window size (in hours) defines the size of the window to be considered 
% (starting from the transition to constant light)

% Sampling rate is the sampling rate required (the current data are sampled
% at 1 datapoint per hour)

% @LaurentMombaerts2019

% Resample and take subset of data
if amount_of_mutations == 0
    dataToUse = current_data(:,1:sampling_rate:(window_size+1));
else
    for i = 1:(amount_of_mutations + 1)
        dataToUse{i} = current_data{1,i}(:,1:sampling_rate:(window_size+1));
    end
end

%% ATA
% Plug in the IO data generation for ATA
IO_data = dataFormattingATA(dataToUse, window_size, sampling_rate, current_mutations);
% Network Inference
confidenceMatrix = All2All(IO_data);

end