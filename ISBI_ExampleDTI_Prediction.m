function Signals = ISBI_ExampleDTI_Prediction(parameters,unprovided_data)
    Signals = NaN([length(unprovided_data.gx1) size(parameters,1)]);    
    
    sqrt_b = [unprovided_data.gx1.*sqrt(unprovided_data.B) unprovided_data.gy1.*sqrt(unprovided_data.B) unprovided_data.gz1.*sqrt(unprovided_data.B)];
    
    if(~isfield(unprovided_data,'Bxx'))
        % The PGSE case, compute the b-matrix from the gradients 

        X = [sqrt_b(:,1).^2 2*sqrt_b(:,1).*sqrt_b(:,2) 2*sqrt_b(:,1).*sqrt_b(:,3)...
        sqrt_b(:,2).^2 2*sqrt_b(:,2).*sqrt_b(:,3) sqrt_b(:,3).^2];
    else
        % There is pre-computed b-matrix (DDE, DODE)
        X = [unprovided_data.Bxx 2*unprovided_data.Bxy 2*unprovided_data.Bxz unprovided_data.Byy 2*unprovided_data.Byz unprovided_data.Bzz];
    end
    
    if size(parameters,2) == 7
        X = [-X ones(size(X,1),1)];
    else
        X = -X;
    end

    % go through the provided signals
    for signal_id = 1:size(Signals,2)
        Signals(:,signal_id) = exp(X*parameters(signal_id,:)'); 
    end
end