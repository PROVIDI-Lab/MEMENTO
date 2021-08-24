% Code used for the preparation and evaluation of the MEMENTO challenge
% organized by Kurt Schilling, Andrada Ianus and Alberto De Luca
% Code author: Alberto De Luca (a.deluca-2@umcutrecht.nl)
% Determines some scores associated to a signal fit
function [synthetic_score, per_signal_score, residuals_statistics] = ISBI_Subchallenge1_SyntheticEvaluation(unprovided_data,rounding_level)
    % The score is computed as MSE

    per_signal_score = NaN(size(unprovided_data.GroundTrueValues,2),1);
    residuals_statistics = NaN(size(unprovided_data.GroundTrueValues,2),4); % Mean, 25, 50, 75th percentile
    for signal_id=1:length(per_signal_score)
       R = (unprovided_data.GroundTrueValues(:,signal_id) - unprovided_data.Signal(:,signal_id)).^2;
       residuals_statistics(signal_id,:) = [mean(R) prctile(R,[25 50 75])];
       per_signal_score(signal_id) = mean(R); 
    end
    synthetic_score = mean((unprovided_data.GroundTrueValues(:)-unprovided_data.Signal(:)).^2);

end

