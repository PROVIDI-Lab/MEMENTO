% Code used for the preparation and evaluation of the MEMENTO challenge
% organized by Kurt Schilling, Andrada Ianus and Alberto De Luca
% Code author: Alberto De Luca (a.deluca-2@umcutrecht.nl)
% This script fits the DTI model to DODE data and evaluates the prediction
% performance

%% Load protocol and data
data = ISBI_LoadSubchallenge1Description('Provided/DODE_ProtocolDescription.txt','Provided/DODE_provided_acq_params.txt');
data.Signals = load('Provided/DODE_provided_signals.txt');

%% As sanity check predict the provided data
test_data = data;
test_data.GroundTrueValues = data.Signals;

%% Perform a DTI fit
DTI_fit = ISBI_ExampleDTI_Fit(data);

%% Calculate metrics
[MD, FA] = ISBI_ExampleDTI_Parameters(DTI_fit);
%% Perform the prediction
PredictedSignals = ISBI_ExampleDTI_Prediction(DTI_fit,test_data);
out_file = 'MySubchallenge1_DTI_DODE_selfprediction.txt';
fout = fopen(out_file,'wt');
for row=1:size(PredictedSignals,1)
    for col=1:size(PredictedSignals,2)
        fprintf(fout,'%f\t',PredictedSignals(row,col));
    end
    fprintf(fout,'\n');
end
fclose(fout);

test_data.Signal = load(out_file);
%% Self-evaluation
ISBI_Subchallenge1_VisualEvaluation(test_data);

[absolute_score,per_signal_score] = ISBI_Subchallenge1_SyntheticEvaluation(test_data);
disp(['The overall score is: ' num2str(absolute_score)]);
for signal_id=1:length(per_signal_score)
   disp(['Signal ' num2str(signal_id) ' partial score: ' num2str(per_signal_score(signal_id))]); 
end

%% Now, predict the unprovided data
test_data = ISBI_LoadSubchallenge1Description('Provided/DODE_ProtocolDescription.txt','Provided/DODE_unprovided_acq_params.txt');

%% Perform the prediction
PredictedSignals = ISBI_ExampleDTI_Prediction(DTI_fit,test_data);
out_file = 'MySubchallenge1_DTI_DODE_prediction.txt';
fout = fopen(out_file,'wt');
for row=1:size(PredictedSignals,1)
    for col=1:size(PredictedSignals,2)
        fprintf(fout,'%f\t',PredictedSignals(row,col));
    end
    fprintf(fout,'\n');
end
fclose(fout);

test_data.Signal = load(out_file);
%% Final evaluation - code not provided to the participants
test_data.GroundTrueValues = load('Unprovided/DODE_unprovided_signals.txt');

ISBI_Subchallenge1_VisualEvaluation(test_data);


[absolute_score,per_signal_score,residuals_3_moments] = ISBI_Subchallenge1_SyntheticEvaluation(test_data);
disp(['The overall score is: ' num2str(absolute_score)]);
for signal_id=1:length(per_signal_score)
   disp(['Signal ' num2str(signal_id) ' partial score: ' num2str(per_signal_score(signal_id))]); 
   disp(['The 25,50,75th percentile of the residuals are: ' num2str(residuals_3_moments(signal_id,:))]);
end

