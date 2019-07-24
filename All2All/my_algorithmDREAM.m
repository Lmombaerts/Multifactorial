function confidenceMatrix = my_algorithmDREAM(data)

% If size data too small for the estimation routine, linear interpolation.
if size(data{1},2) < 15
    initSampling = (0:size(data{1},2)-1)*2;
    newSampling = 0:(size(data{1},2)-1)*2;
    % Linear interpolation
    if size(data,2) == 1
        dataInterp{1} = linearInterpData(data{1},initSampling,newSampling);
    elseif size(data,2) == 2
        dataInterp{1} = linearInterpData(data{1},initSampling,newSampling);
        dataInterp{2} = linearInterpData(data{2},initSampling,newSampling);
    elseif size(data,2) == 3
        dataInterp{1} = linearInterpData(data{1},initSampling,newSampling);
        dataInterp{2} = linearInterpData(data{2},initSampling,newSampling);
        dataInterp{3} = linearInterpData(data{3},initSampling,newSampling);
    elseif size(data,2) == 4
        dataInterp{1} = linearInterpData(data{1},initSampling,newSampling);
        dataInterp{2} = linearInterpData(data{2},initSampling,newSampling);
        dataInterp{3} = linearInterpData(data{3},initSampling,newSampling);
        dataInterp{4} = linearInterpData(data{4},initSampling,newSampling);
    end
    % Plug in the IO data generation for ATA
    IO_data = dataFormattingATA_DREAM(dataInterp);
else
    % Plug in the IO data generation for ATA
    IO_data = dataFormattingATA_DREAM(data);
end
    
% Network Inference
confidenceMatrix = All2All(IO_data);

end