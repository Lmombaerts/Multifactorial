%Code to change the amount of available data for each of the previously
%saved data @LaurentMombaerts2019
clear; close all;

addpath([pwd '/Data']);
addpath([pwd '/All2All']);
addpath([pwd '/Others']);

replicates = 10;
amount_randomization = 6;
amount_mutations = [0 1 2 3];
window_size = [24 36 48 60 72]; % Hours
sampling_rate_inference = 1; % 1 data point every 4 hours
t = 0:72; % Original sampling rate from the data starting from transients

filename_WT = 'Millar_WT_only.mat';

filenames_1Mut = {'Millar_WTandMut_1.mat';
'Millar_WTandMut_2.mat';
'Millar_WTandMut_3.mat';
'Millar_WTandMut_4.mat';
'Millar_WTandMut_5.mat';
'Millar_WTandMut_6.mat'};

filenames_2Mut = {'Millar_WTandMut_12.mat';
'Millar_WTandMut_23.mat';
'Millar_WTandMut_24.mat';
'Millar_WTandMut_34.mat';
'Millar_WTandMut_45.mat';
'Millar_WTandMut_56.mat'};

filenames_3Mut = {'Millar_WTandMut_135.mat';
'Millar_WTandMut_136.mat';
'Millar_WTandMut_236.mat';
'Millar_WTandMut_345.mat';
'Millar_WTandMut_356.mat';
'Millar_WTandMut_456.mat'};


for i = amount_mutations
    if i == 0
        load(filename_WT); % Only WT since no mutation
        current_mutations = NaN;
        temp = 0;
        for j = window_size
            temp = temp + 1;
            idx_end = find(t == j);
            parfor k = 1:replicates
                current_data = data{k};
                
                % Run network inference without mutants data
                fprintf('Running WT only, replicate %d, window_size %d \n',k,j);                
                confidenceMatrix_WT{temp,k} = my_algorithm(current_data,j,sampling_rate_inference,i,current_mutations);
 
                % Estimate accuracy
                [~,~,~,~,~,~,~,~,AUROC(temp,k),AUPREC(temp,k)] = ROC_Millar10(confidenceMatrix_WT{temp,k}); % Performances
                
            end
        end
        save Millar10_Results_WT_Only AUROC AUPREC confidenceMatrix_WT
    elseif i == 1        
        for l = 1:amount_randomization
            load(filenames_1Mut{l});
            temp = 0;
            for j = window_size
                temp = temp + 1;
                idx_end = find(t == j);
                parfor k = 1:replicates                   
                    current_data = data(k,:);
                    
                    % Run network inference without mutants data
                    fprintf('Running 1 Mutant (%d), replicate %d, window_size %d \n',l,k,j);                     
                    confidenceMatrix_WTand1Mut{temp,k,l} = my_algorithm(current_data,j,sampling_rate_inference,i,current_mutations);
                    
                    % Estimate accuracy
                    [~,~,~,~,~,~,~,~,AUROC_1Mut(temp,k,l),AUPREC_1Mut(temp,k,l)] = ROC_Millar10(confidenceMatrix_WTand1Mut{temp,k,l}); % Performances
                    
                end                
            end
        end
        save Millar10_Results_One_Mut AUROC_1Mut AUPREC_1Mut confidenceMatrix_WTand1Mut
    elseif i == 2
       for l = 1:amount_randomization
           load(filenames_2Mut{l});
           temp = 0;
            for j = window_size
                temp = temp + 1;
                idx_end = find(t == j);
                parfor k = 1:replicates
                   current_data = data(k,:);
                   
                   % Run network inference without mutants data
                   fprintf('Running 2 Mutants (%d), replicate %d, window_size %d \n',l,k,j); 
                   confidenceMatrix_WTand2Mut{temp,k,l} = my_algorithm(current_data,j,sampling_rate_inference,i,current_mutations);
                   
                   % Estimate accuracy
                   [~,~,~,~,~,~,~,~,AUROC_2Mut(temp,k,l),AUPREC_2Mut(temp,k,l)] = ROC_Millar10(confidenceMatrix_WTand2Mut{temp,k,l}); % Performances
                end                
            end
       end
       save Millar10_Results_Two_Mut AUROC_2Mut AUPREC_2Mut confidenceMatrix_WTand2Mut
    elseif i == 3
        for l = 1:amount_randomization
            load(filenames_3Mut{l});
            temp = 0;
            for j = window_size
                temp = temp + 1;
                idx_end = find(t == j);
                parfor k = 1:replicates
                   current_data = data(k,:);
                   
                   % Run network inference without mutants data
                   fprintf('Running 3 Mutants (%d), replicate %d, window_size %d \n',l,k,j);                   
                   confidenceMatrix_WTand3Mut{temp,k,l} = my_algorithm(current_data,j,sampling_rate_inference,i,current_mutations);
                   
                   % Estimate accuracy
                   [~,~,~,~,~,~,~,~,AUROC_3Mut(temp,k,l),AUPREC_3Mut(temp,k,l)] = ROC_Millar10(confidenceMatrix_WTand3Mut{temp,k,l}); % Performances
               end                
            end
        end
        save Millar10_Results_Three_Mut_dynGENIE3_WithConfidenceMatrix AUROC_3Mut AUPREC_3Mut confidenceMatrix_WTand3Mut
    end
end
    
