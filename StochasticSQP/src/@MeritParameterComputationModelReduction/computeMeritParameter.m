% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: computeMeritParameter
function computeMeritParameter(M,options,quantities,reporter,strategies)

%%%%%%%%%%%%%%%%%%%
% MERIT PARAMETER %
%%%%%%%%%%%%%%%%%%%


% Compute objective model value
objective_model_value = quantities.currentIterate.objectiveGradient(quantities,'stochastic')'*quantities.directionPrimal + ...
    max(quantities.curvatureInfo, M.curvature_threshold_ * norm(quantities.directionPrimal)^2);

% Evaluate constraint violation norm
if quantities.currentIterate.constraintNorm1 > 0.0 
    
    % Initialize trial value
    merit_parameter_trial = inf;
    
    % Check sign of objective model value
    if objective_model_value > 0.0 && (quantities.terminationTestNumber == -1 || quantities.terminationTestNumber == 2)
        
        % Update trial value
        merit_parameter_trial = ((1 - M.model_reduction_factor_) * quantities.currentIterate.constraintNorm1 - quantities.residualDualNorm1) / objective_model_value;
        
    end
    
    % Check trial value
    if quantities.meritParameter > merit_parameter_trial
        
        % Set merit parameter
        quantities.setMeritParameter((1 - M.parameter_reduction_factor_) * merit_parameter_trial);
        
    end
    
end % quantities.constraintNorm1 > 0.0


%%%%%%%%%%%%%%%%%%%
% MODEL REDUCTION %
%%%%%%%%%%%%%%%%%%%

if M.quadratic_model_
    
    % Set model reduction
    quantities.setModelReduction(-quantities.meritParameter * (objective_model_value - ...
        (1/2)*max(quantities.directionPrimal' * quantities.directionPrimal,...
        M.curvature_threshold_ * norm(quantities.directionPrimal)^2)) + quantities.currentIterate.constraintNorm1);
    
elseif M.linear_model_
    
    % Set model reduction
    quantities.setModelReduction(-quantities.meritParameter * quantities.currentIterate.objectiveGradient(quantities,'stochastic')'*quantities.directionPrimal + ...
        quantities.currentIterate.constraintNorm1 - quantities.residualDualNorm1);
    
end

%%%%%%%%%%%%%%%%%%%
% RATIO PARAMETER %
%%%%%%%%%%%%%%%%%%%

% Initialize trial value
ratio_parameter_trial = quantities.modelReduction / (quantities.meritParameter * norm(quantities.directionPrimal)^2);

% Check trial value
if quantities.ratioParameter > ratio_parameter_trial
  
  % Set ratio parameter
  quantities.setRatioParameter((1 - M.parameter_reduction_factor_) * ratio_parameter_trial);
  
end

end % computeMeritParameter