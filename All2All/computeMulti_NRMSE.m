function NRMSE_ATA = computeMulti_NRMSE(y_ref,y_hat)
% y_ref/y_hat are X*Y matrices where X is the amount of experiments and Y 
% is the amount of datapoints.
% This function is an extension of the fitness score for several
% experiments (NRMSE extended)
% @LaurentMombaerts2019 - Current version is hard-coded, improvements
% required

exp_amount = size(y_ref,1);

if exp_amount == 1
    num1 = norm(y_ref(1,:) - y_hat(1,:));
    den1 = norm(y_ref(1,:) - mean(y_ref(1,:)));
    NRMSE_ATA = 100 * (1 - num1/den1);
elseif exp_amount == 2
    num1 = norm(y_ref(1,:) - y_hat(1,:));
    den1 = norm(y_ref(1,:) - mean(y_ref(1,:)));
    num2 = norm(y_ref(2,:) - y_hat(2,:));
    den2 = norm(y_ref(2,:) - mean(y_ref(2,:)));
    NRMSE_ATA = 100 * (1 - (num1 + num2)/(den1 + den2));
elseif exp_amount == 3
    num1 = norm(y_ref(1,:) - y_hat(1,:));
    den1 = norm(y_ref(1,:) - mean(y_ref(1,:)));
    num2 = norm(y_ref(2,:) - y_hat(2,:));
    den2 = norm(y_ref(2,:) - mean(y_ref(2,:)));
    num3 = norm(y_ref(3,:) - y_hat(3,:));
    den3 = norm(y_ref(3,:) - mean(y_ref(3,:)));
    NRMSE_ATA = 100 * (1 - (num1 + num2 + num3)/(den1 + den2 + den3));
elseif exp_amount == 4
    num1 = norm(y_ref(1,:) - y_hat(1,:));
    den1 = norm(y_ref(1,:) - mean(y_ref(1,:)));
    num2 = norm(y_ref(2,:) - y_hat(2,:));
    den2 = norm(y_ref(2,:) - mean(y_ref(2,:)));
    num3 = norm(y_ref(3,:) - y_hat(3,:));
    den3 = norm(y_ref(3,:) - mean(y_ref(3,:)));
    num4 = norm(y_ref(4,:) - y_hat(4,:));
    den4 = norm(y_ref(4,:) - mean(y_ref(4,:)));
    NRMSE_ATA = 100 * (1 - (num1 + num2 + num3 + num4)/(den1 + den2 + den3 + den4));
end
    
end