function dataInterp = linearInterpData(data,initSampling,newSampling)

for i = 1:size(data,1)
    dataInterp(i,:) = interp1(initSampling,data(i,:),newSampling);
end
    
end