function IO_data = dataFormattingATA_DREAM(dataToUse)
% Here we need to merge everything together

for i = 1:size(dataToUse{1},1)
    for j = 1:size(dataToUse{1},1)
        if i ~= j
            if size(dataToUse,2) == 1
                IO_data{i,j} = iddata(dataToUse{1}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
            elseif size(dataToUse,2) == 2
                d1 = iddata(dataToUse{1}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                d2 = iddata(dataToUse{2}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                IO_data{i,j} = merge(d1,d2);
            elseif size(dataToUse,2) == 3
                d1 = iddata(dataToUse{1}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                d2 = iddata(dataToUse{2}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                d3 = iddata(dataToUse{3}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                IO_data{i,j} = merge(d1,d2,d3);
            elseif size(dataToUse,2) == 4
                d1 = iddata(dataToUse{1}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                d2 = iddata(dataToUse{2}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                d3 = iddata(dataToUse{3}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                d4 = iddata(dataToUse{4}(j,:)',[dataToUse{1}(i,:)' ones(size(dataToUse{1}(i,:)'))],1);
                IO_data{i,j} = merge(d1,d2,d3,d4);
            end
        else
            IO_data{i,j} = NaN;
        end
    end
end



end