% Run network inference using the DREAM Data we generated with GNW
% @LaurentMombaerts 2019
clear; close all;

load('data_DREAM_insilico10.mat');
load('GT_DREAM.mat');

samplingRates = [4 2 1];

for i = 1:5 % Network 1:5
    for j = 1:5 % Perturbations Randomization 1:5
        for l = 1:9 % Dummy index for parallelisation
            fprintf('Running dummy index %d for network %d and perturbation %d \n',l,i,j);
            k=floor((l-1)/3)+1; % Replicate number
            temp=mod(l-1,3)+1;  % Sampling rate number
            samplingRate = samplingRates(temp);
            
            dataOnePert{1} = data_OnePert{i,j,k}(1:samplingRate:end,:)';
            
            % Run my inference using dataOnePert
            confidenceMatrix_One{i,j,k,temp} = my_algorithmDREAM(dataOnePert);
            
            % Result Computation
            [~,~,~,~,~,~,~,~,AUROC_OnePert(i,j,k,temp),AUPREC_OnePert(i,j,k,temp)] = ROC_DREAM(i,confidenceMatrix_One{i,j,k,temp}); % Performances

            dataTwoPert{1} = data_TwoPert{i,j,k,1}(1:samplingRate:end,:)';
            dataTwoPert{2} = data_TwoPert{i,j,k,2}(1:samplingRate:end,:)';
            
            % Run my inference using dataTwoPert
            confidenceMatrix_Two{i,j,k,temp} = my_algorithmDREAM(dataTwoPert);
            
            % Result Computation
            [~,~,~,~,~,~,~,~,AUROC_TwoPert(i,j,k,temp),AUPREC_TwoPert(i,j,k,temp)] = ROC_DREAM(i,confidenceMatrix_Two{i,j,k,temp}); % Performances
            
            dataThreePert{1} = data_ThreePert{i,j,k,1}(1:samplingRate:end,:)';
            dataThreePert{2} = data_ThreePert{i,j,k,2}(1:samplingRate:end,:)';
            dataThreePert{3} = data_ThreePert{i,j,k,3}(1:samplingRate:end,:)';
            
            % Run my inference using dataThreePert
            confidenceMatrix_Three{i,j,k,temp} = my_algorithmDREAM(dataThreePert);
            
            % Result Computation
            [~,~,~,~,~,~,~,~,AUROC_ThreePert(i,j,k,temp),AUPREC_ThreePert(i,j,k,temp)] = ROC_DREAM(i,confidenceMatrix_Three{i,j,k,temp}); % Performances
            
            dataFourPert{1} = data_FourPert{i,j,k,1}(1:samplingRate:end,:)';
            dataFourPert{2} = data_FourPert{i,j,k,2}(1:samplingRate:end,:)';
            dataFourPert{3} = data_FourPert{i,j,k,3}(1:samplingRate:end,:)';
            dataFourPert{4} = data_FourPert{i,j,k,4}(1:samplingRate:end,:)';
            
            % Run my inference using dataFourPert
            confidenceMatrix_Four{i,j,k,temp} = my_algorithmDREAM(dataFourPert);
            
            % Result Computation
            [~,~,~,~,~,~,~,~,AUROC_FourPert(i,j,k,temp),AUPREC_FourPert(i,j,k,temp)] = ROC_DREAM(i,confidenceMatrix_Four{i,j,k,temp}); % Performances
       end
    end
end

save results_DREAM_ATA_withConfidenceMatrix AUROC_OnePert AUROC_TwoPert AUROC_ThreePert AUROC_FourPert AUPREC_OnePert AUPREC_TwoPert AUPREC_ThreePert AUPREC_FourPert confidenceMatrix_One confidenceMatrix_Two confidenceMatrix_Three confidenceMatrix_Four 