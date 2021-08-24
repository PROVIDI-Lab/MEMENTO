% Code used for the preparation and evaluation of the MEMENTO challenge
% organized by Kurt Schilling, Andrada Ianus and Alberto De Luca
% Code author: Alberto De Luca (a.deluca-2@umcutrecht.nl)
% This script can be used to evaluate a signal prediction

%% Adjust accordingly
clear
clc
type_of_data = 2; % 1 = PGSE-shells, 2 = PGSE-grids, 3 = DDE, 4 = DODE
prediction_to_evaluate = '/Volumes/KINGSTON/Work/Data/MEMENTO/Challenge/downloaded_data/VLAB/analysis_874591/PROCESS/submission.txt';

%% Do not alter the code below

if(type_of_data == 1)
    data = ISBI_LoadSubchallenge1Description('Provided/PGSE_ProtocolDescription.txt','Provided/PGSE_shells_provided_acq_params.txt');
    data.Signals = load('Provided/PGSE_shells_provided_signals.txt');
    test_data = ISBI_LoadSubchallenge1Description('Provided/PGSE_ProtocolDescription.txt','Provided/PGSE_shells_unprovided_acq_params.txt');
    test_data.GroundTrueValues = load('Unprovided/PGSE_shells_unprovided_signals.txt');
    rounding_level = 10;
elseif(type_of_data == 2)
    data = ISBI_LoadSubchallenge1Description('Provided/PGSE_ProtocolDescription.txt','Provided/PGSE_grids_provided_acq_params.txt');
    data.Signals = load('Provided/PGSE_grids_provided_signals.txt');
    test_data = ISBI_LoadSubchallenge1Description('Provided/PGSE_ProtocolDescription.txt','Provided/PGSE_grids_unprovided_acq_params.txt');
    test_data.GroundTrueValues = load('Unprovided/PGSE_grids_unprovided_signals.txt');
    rounding_level = 100;
elseif(type_of_data == 3)
    data = ISBI_LoadSubchallenge1Description('Provided/DDE_ProtocolDescription.txt','Provided/DDE_provided_acq_params.txt');
    data.Signals = load('Provided/DDE_provided_signals.txt');
    test_data = ISBI_LoadSubchallenge1Description('Provided/DDE_ProtocolDescription.txt','Provided/DDE_unprovided_acq_params.txt');
    test_data.GroundTrueValues = load('Unprovided/DDE_unprovided_signals.txt');
    rounding_level = 100;
elseif(type_of_data == 4)
    data = ISBI_LoadSubchallenge1Description('Provided/DODE_ProtocolDescription.txt','Provided/DODE_provided_acq_params.txt');
    data.Signals = load('Provided/DODE_provided_signals.txt');
    test_data = ISBI_LoadSubchallenge1Description('Provided/DODE_ProtocolDescription.txt','Provided/DODE_unprovided_acq_params.txt');
    test_data.GroundTrueValues = load('Unprovided/DODE_unprovided_signals.txt');
    rounding_level = 100;
end

test_data.Signal = load(prediction_to_evaluate);

if(any(size(test_data.Signal) ~= size(test_data.GroundTrueValues)))
    warning('Invalid prediction length. Please check whether type_of_data is correct.');
end

%% Evaluate

ISBI_Subchallenge1_VisualEvaluation(test_data);

[absolute_score,per_signal_score,residuals_3_moments] = ISBI_Subchallenge1_SyntheticEvaluation(test_data,rounding_level);
disp(['The overall score is: ' num2str(absolute_score)]);
for signal_id=1:length(per_signal_score)
   disp(['Signal ' num2str(signal_id) ' partial score: ' num2str(per_signal_score(signal_id))]); 
   disp(['The 25,50,75th percentile of the residuals are: ' num2str(residuals_3_moments(signal_id,:))]);
end

