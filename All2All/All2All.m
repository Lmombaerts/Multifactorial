function NRMSE_ATA = All2All(IO_data)
%Compute fitness scores for the All to All from the data generated
%NRMSE_ATA is of size IO_data - current version is hard-coded, improvements
%are required
opt = tfestOptions('InitMethod','n4sid'); %Option for system ID ATA initial estimate technique.
NRMSE_ATA = zeros(size(IO_data,1),size(IO_data,1));
warning off;
for input = 1:size(IO_data,1)
    parfor output = 1:size(IO_data,1)
        if input ~= output
            warning off;
            model = tfest(IO_data{input,output}, [1 0], opt); %0 order model for additional input = offset
            
            % Here compute the NRMSE by hand
            amount_exp = size(IO_data{input,output}.Exp,1); %Finds the amount of experiments available for this pair

            % Returns the output of each estimated model
            [y_hats,fit] = compare(IO_data{input,output}, model);
            
            if amount_exp == 1
                NRMSE_ATA(input,output) = fit;
                if NRMSE_ATA(input,output) < 0
                    NRMSE_ATA(input,output) = 0;
                end
            elseif amount_exp == 2
                y_ref1 = IO_data{input,output}.y{1,1};
                y_hat1 = y_hats{1,1}.y;
                y_ref2 = IO_data{input,output}.y{1,2};
                y_hat2 = y_hats{1,2}.y;
                
                % NRMSE computation (extension of the fitness score)
                NRMSE_ATA_temp = computeMulti_NRMSE([y_ref1 y_ref2]',[y_hat1 y_hat2]');
                NRMSE_ATA(input,output) = NRMSE_ATA_temp;
                if NRMSE_ATA(input,output) < 0
                    NRMSE_ATA(input,output) = 0;
                end
            elseif amount_exp == 3
                y_ref1 = IO_data{input,output}.y{1,1}; 
                y_hat1 = y_hats{1,1}.y; 
                y_ref2 = IO_data{input,output}.y{1,2}; 
                y_hat2 = y_hats{1,2}.y;
                y_ref3 = IO_data{input,output}.y{1,3}; 
                y_hat3 = y_hats{1,3}.y;
                
                % NRMSE computation (extension of the fitness score)
                NRMSE_ATA_temp = computeMulti_NRMSE([y_ref1 y_ref2 y_ref3]',[y_hat1 y_hat2 y_hat3]');
                NRMSE_ATA(input,output) = NRMSE_ATA_temp;
                if NRMSE_ATA(input,output) < 0
                    NRMSE_ATA(input,output) = 0;
                end
            elseif amount_exp == 4
                y_ref1 = IO_data{input,output}.y{1,1}; 
                y_hat1 = y_hats{1,1}.y;
                y_ref2 = IO_data{input,output}.y{1,2}; 
                y_hat2 = y_hats{1,2}.y; 
                y_ref3 = IO_data{input,output}.y{1,3}; 
                y_hat3 = y_hats{1,3}.y; 
                y_ref4 = IO_data{input,output}.y{1,4}; 
                y_hat4 = y_hats{1,4}.y;
                
                % NRMSE computation (extension of the fitness score)
                NRMSE_ATA_temp = computeMulti_NRMSE([y_ref1 y_ref2 y_ref3 y_ref4]',[y_hat1 y_hat2 y_hat3 y_hat4]');
                NRMSE_ATA(input,output) = NRMSE_ATA_temp; 
                if NRMSE_ATA(input,output) < 0
                    NRMSE_ATA(input,output) = 0;
                end
            end
        else
            NRMSE_ATA(input,output) = 0;
        end       
    end
end

end