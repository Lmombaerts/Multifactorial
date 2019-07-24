function IO_data = dataFormattingATA(dataToUse, window_size, sampling_rate, current_mutations)

if isnan(current_mutations) % Only WT data
    % Interpolation of data
    dataInterpolated = pcs(dataToUse, 0:sampling_rate:window_size, 0:window_size); % Cubic Spline interpolation every hour
    for i = 1:size(dataToUse,1)
        for j = 1:size(dataToUse,1)
            if i ~= j
                IO_data{i,j} = iddata(dataInterpolated(j,:)',[dataInterpolated(i,:)' ones(size(dataInterpolated(i,:)'))],1);
            else
                IO_data{i,j} = NaN;
            end
        end
    end
elseif length(current_mutations) == 1
    data_WT = dataToUse{1,1};
    data_WT_interpolated = pcs(data_WT, 0:sampling_rate:window_size, 0:window_size);
    data_supp1 = dataToUse{1,2};
    data_supp1_Interpolated = pcs(data_supp1, 0:sampling_rate:window_size, 0:window_size); 
    for i = 1:size(data_WT,1)
        for j = 1:size(data_WT,1)
            if i ~= j
                if i == current_mutations || j == current_mutations % Mutated gene needs to be excluded (either input or output)
                    IO_data{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1); % Do not merge the new data
                else
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d2{i,j} = iddata(data_supp1_Interpolated(j,:)',[data_supp1_Interpolated(i,:)' ones(size(data_supp1_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d2{i,j});
                end
            else
                IO_data{i,j} = NaN;
            end
        end
    end
elseif length(current_mutations) == 2
    data_WT = dataToUse{1,1};
    data_WT_interpolated = pcs(data_WT, 0:sampling_rate:window_size, 0:window_size);
    data_supp1 = dataToUse{1,2};
    data_supp1_Interpolated = pcs(data_supp1, 0:sampling_rate:window_size, 0:window_size); 
    data_supp2 = dataToUse{1,3};
    data_supp2_Interpolated = pcs(data_supp2, 0:sampling_rate:window_size, 0:window_size); 
    for i = 1:size(data_WT_interpolated,1)
        for j = 1:size(data_WT_interpolated,1)
            if i ~= j
                if (i == current_mutations(1) && j == current_mutations(2)) || (i == current_mutations(2) && j == current_mutations(1)) % No models between mutants can be estimated here
                    IO_data{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                elseif i == current_mutations(1) || j == current_mutations(1) % Mutated genes need to be excluded
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d3{i,j} = iddata(data_supp2_Interpolated(j,:)',[data_supp2_Interpolated(i,:)' ones(size(data_supp2_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d3{i,j});
                elseif i == current_mutations(2) || j == current_mutations(2) % Mutated genes need to be excluded
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d2{i,j} = iddata(data_supp1_Interpolated(j,:)',[data_supp1_Interpolated(i,:)' ones(size(data_supp1_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d2{i,j});
                else
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d2{i,j} = iddata(data_supp1_Interpolated(j,:)',[data_supp1_Interpolated(i,:)' ones(size(data_supp1_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    d3{i,j} = iddata(data_supp2_Interpolated(j,:)',[data_supp2_Interpolated(i,:)' ones(size(data_supp2_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d2{i,j},d3{i,j});
                end
            else
                IO_data{i,j} = NaN;
            end
        end
    end
elseif length(current_mutations) == 3
    data_WT = dataToUse{1,1};
    data_WT_interpolated = pcs(data_WT, 0:sampling_rate:window_size, 0:window_size);
    data_supp1 = dataToUse{1,2};
    data_supp1_Interpolated = pcs(data_supp1, 0:sampling_rate:window_size, 0:window_size);
    data_supp2 = dataToUse{1,3};
    data_supp2_Interpolated = pcs(data_supp2, 0:sampling_rate:window_size, 0:window_size); 
    data_supp3 = dataToUse{1,4};
    data_supp3_Interpolated = pcs(data_supp3, 0:sampling_rate:window_size, 0:window_size); 
    for i = 1:size(data_WT_interpolated,1)
        for j = 1:size(data_WT_interpolated,1)
            if i ~= j
                if (i == current_mutations(1) && j == current_mutations(2)) || (i == current_mutations(2) && j == current_mutations(1)) 
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d4{i,j} = iddata(data_supp3_Interpolated(j,:)',[data_supp3_Interpolated(i,:)' ones(size(data_supp3_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d4{i,j});
                elseif (i == current_mutations(1) && j == current_mutations(3)) || (i == current_mutations(3) && j == current_mutations(1))
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d3{i,j} = iddata(data_supp2_Interpolated(j,:)',[data_supp2_Interpolated(i,:)' ones(size(data_supp2_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d3{i,j});
                elseif (i == current_mutations(2) && j == current_mutations(3)) || (i == current_mutations(3) && j == current_mutations(2)) 
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d2{i,j} = iddata(data_supp1_Interpolated(j,:)',[data_supp1_Interpolated(i,:)' ones(size(data_supp1_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d2{i,j});
                elseif i == current_mutations(1) || j == current_mutations(1) % Mutated genes need to be excluded
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d3{i,j} = iddata(data_supp2_Interpolated(j,:)',[data_supp2_Interpolated(i,:)' ones(size(data_supp2_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    d4{i,j} = iddata(data_supp3_Interpolated(j,:)',[data_supp3_Interpolated(i,:)' ones(size(data_supp3_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d3{i,j},d4{i,j});
                elseif i == current_mutations(2) || j == current_mutations(2) 
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d2{i,j} = iddata(data_supp1_Interpolated(j,:)',[data_supp1_Interpolated(i,:)' ones(size(data_supp1_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    d4{i,j} = iddata(data_supp3_Interpolated(j,:)',[data_supp3_Interpolated(i,:)' ones(size(data_supp3_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d2{i,j},d4{i,j});
                elseif i == current_mutations(3) || j == current_mutations(3) 
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d2{i,j} = iddata(data_supp1_Interpolated(j,:)',[data_supp1_Interpolated(i,:)' ones(size(data_supp1_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    d3{i,j} = iddata(data_supp2_Interpolated(j,:)',[data_supp2_Interpolated(i,:)' ones(size(data_supp2_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d2{i,j},d3{i,j});
                else
                    d1{i,j} = iddata(data_WT_interpolated(j,:)',[data_WT_interpolated(i,:)' ones(size(data_WT_interpolated(i,:)'))],1);
                    d2{i,j} = iddata(data_supp1_Interpolated(j,:)',[data_supp1_Interpolated(i,:)' ones(size(data_supp1_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    d3{i,j} = iddata(data_supp2_Interpolated(j,:)',[data_supp2_Interpolated(i,:)' ones(size(data_supp2_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    d4{i,j} = iddata(data_supp3_Interpolated(j,:)',[data_supp3_Interpolated(i,:)' ones(size(data_supp3_Interpolated(i,:)'))],1);% IO corresponding to mutants
                    IO_data{i,j} = merge(d1{i,j},d2{i,j},d3{i,j},d4{i,j});
                end
            else
                IO_data{i,j} = NaN;
            end
        end
    end
end

end