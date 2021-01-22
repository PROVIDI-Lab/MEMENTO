function [synthetic_score, per_signal_score, residuals_statistics] = ISBI_Subchallenge1_SyntheticEvaluation(unprovided_data,weight_data)
    % The score is computed as MSE
    per_signal_score = NaN(size(unprovided_data.GroundTrueValues,2),1);
    residuals_statistics = NaN(size(unprovided_data.GroundTrueValues,2),4); % Mean, 25, 50, 75th percentile
    
    if(nargin > 1 && weight_data == 1)
        weights = zeros(length(unprovided_data.B),1);
        for bval_id=1:length(weights)
           weights(bval_id) = 1/length(find(unprovided_data.B == unprovided_data.B(bval_id)));
        end
    else
        weights = ones(length(unprovided_data.B),1);
    end
    
    for signal_id=1:length(per_signal_score)
       R = (unprovided_data.GroundTrueValues(:,signal_id) - unprovided_data.Signal(:,signal_id)).*(weights);
       residuals_statistics(signal_id,:) = [mean(R) prctile(R,[25 50 75])];
       per_signal_score(signal_id) = mean(R.^2/sum(weights)); 
    end
    synthetic_score = sum(per_signal_score);
    
end