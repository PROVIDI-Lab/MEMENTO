% Code used for the preparation and evaluation of the MEMENTO challenge
% organized by Kurt Schilling, Andrada Ianus and Alberto De Luca
% Code author: Alberto De Luca (a.deluca-2@umcutrecht.nl)
% This script fits the DTI model to a given signal
function parameters = ISBI_ExampleDTI_Fit(data,fitS0)
if nargin <2
    fitS0 = 1;
end
if fitS0
    nof_estimates = 7;
else
    nof_estimates = 6;
end
    parameters = zeros([size(data.Signals,2) nof_estimates]);
    
    if(~isfield(data,'Bxx'))
        % The PGSE case, compute the b-matrix from the gradients 
        
        sqrt_b = [data.gx1.*sqrt(data.B) data.gy1.*sqrt(data.B) data.gz1.*sqrt(data.B)];

        X = [sqrt_b(:,1).^2 2*sqrt_b(:,1).*sqrt_b(:,2) 2*sqrt_b(:,1).*sqrt_b(:,3)...
        sqrt_b(:,2).^2 2*sqrt_b(:,2).*sqrt_b(:,3) sqrt_b(:,3).^2];

    else
        % There is pre-computed b-matrix (DDE, DODE)
        X = [data.Bxx 2*data.Bxy 2*data.Bxz data.Byy 2*data.Byz data.Bzz];
    end
if fitS0
    % Also fit the b=0s/mm2 intensity
    X = [-X ones(size(X,1),1)];
else
    X = -X;
end
    
    % go through the provided signals
    for signal_id = 1:size(data.Signals,2)
        parameters(signal_id,:) = X\log(data.Signals(:,signal_id)); 
    end
end