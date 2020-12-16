% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StochasticSQP: optimize
function optimize(S,problem)

% Get options
S.getOptions;

% Initialize quantities
S.quantities_.initialize(problem);

% Scale problem
S.quantities_.currentIterate.determineScaleFactors(S.quantities_);

% if S.quantities_.currentIterate.numberOfVariables + ...
%         S.quantities_.currentIterate.numberOfConstraintsEqualities + ...
%         S.quantities_.currentIterate.numberOfConstraintsInequalities <= ...
%         S.quantities_.sizeLimit
    
    % Estimate Lipschitz Constants
    currentIterate = S.quantities_.currentIterate.primalPoint;
    currentTrueObjectiveGradient = S.quantities_.currentIterate.trueObjectiveGradient(S.quantities_);
    currentJacobian = S.quantities_.currentIterate.constraintJacobianEqualities(S.quantities_);
    n = S.quantities_.currentIterate.numberOfVariables;
    m = S.quantities_.currentIterate.numberOfConstraintsEqualities;
    objectiveLipschitz = 1;
    constraintsLipschitz = zeros(m,1);
    
    n
    
    for i = 1:n
        
        i
        
        sampleIterate = currentIterate;
        sampleIterate(i) = sampleIterate(i) + 1e-4;
        [f_scale,cE_scale,~] = S.quantities_.currentIterate.scaleFactors;
        sampleTrueObjectiveGradient = f_scale * problem.evaluateTrueObjectiveGradient(sampleIterate);
        sampleJacobian = cE_scale .* problem.evaluateConstraintJacobianEqualities(sampleIterate);
        
        % Update Lipschitz estimates
        objectiveLipschitz = max(objectiveLipschitz , 1e+4 * norm(currentTrueObjectiveGradient - sampleTrueObjectiveGradient));
        blank = zeros(m,1);
        for j = 1:m
            blank(j) = 1e+4 * norm(currentJacobian(j,:) - sampleJacobian(j,:));
            % constraintsLipschitz(j) = max(constraintsLipschitz(j) , 1e+4 * norm(currentJacobian(j,:) - sampleJacobian(j,:)));
        end
        constraintsLipschitz = max(constraintsLipschitz , blank);
        
    end
    
    constraintsLipschitz = sum(constraintsLipschitz);
    Lipschitz_constants = [objectiveLipschitz ; constraintsLipschitz];
    
    % Set Lipschitz Constants
    S.quantities_.setLipschitzConstants(objectiveLipschitz,constraintsLipschitz);
    
    % Save Lipschitz Information
    filename = strcat('/Users/baoyuzhou/Desktop/Software/SCO/output/problem_info/Lipschitz/',problem.name,'.mat');
    save(filename,'Lipschitz_constants');
    
% end

% % Initialize strategies
% S.strategies_.initialize(S.options_,S.quantities_,S.reporter_);
% 
% % Print header
% S.printHeader(problem);
% 
% % Main loop
% while true
%   
%   % Print iteration header
%   S.printIterationHeader;
%   
%   % Print iteration quantities
%   S.quantities_.printIterationValues(S.reporter_);
%   
%   % Check for CPU time termination
%   if S.quantities_.CPUTime >= S.quantities_.CPUTimeLimit
%     S.status_ = Enumerations.S_CPU_TIME_LIMIT;
%     break;
%   end
%   
%   % Check for termination
%   if S.quantities_.currentIterate.numberOfVariables + ...
%       S.quantities_.currentIterate.numberOfConstraintsEqualities + ...
%       S.quantities_.currentIterate.numberOfConstraintsInequalities > ...
%       S.quantities_.sizeLimit
%     S.status_ = Enumerations.S_SIZE_LIMIT;
%     break;
%   end
%   if S.quantities_.iterationCounter >= S.quantities_.iterationLimit
%     S.status_ = Enumerations.S_ITERATION_LIMIT;
%     break;
%   end
%   if S.quantities_.innerIterationCounter >= S.quantities_.innerIterationRelativeLimit * ...
%           (S.quantities_.currentIterate.numberOfVariables + S.quantities_.currentIterate.numberOfConstraintsEqualities)
%     S.status_ = Enumerations.S_ITERATION_LIMIT;
%     break;
%   end
%   
%   % Compute search direction (sets direction)
%   err = S.strategies_.directionComputation.computeDirection(S.options_,S.quantities_,S.reporter_,S.strategies_);
%   
%   % Check for error
%   if err == true
%     S.status_ = Enumerations.S_DIRECTION_COMPUTATION_FAILURE;
%     break;
%   end
%   
%   % Print direction computation values
%   S.strategies_.directionComputation.printIterationValues(S.quantities_,S.reporter_);
%   
% %   % Check for termination
% %   if S.quantities_.currentIterate.stationarityMeasure(S.quantities_) <= S.quantities_.stationarityTolerance
% %     S.status_ = Enumerations.S_SUCCESS;
% %     break;
% %   end
% 
%   % Check for termination of best iterate
%   if S.quantities_.bestIterate.constraintNormInf(S.quantities_) <= 1e-6
%       if S.quantities_.bestIterate.trueStationarityMeasure(S.quantities_) <= 1e-3
%           S.status_ = Enumerations.S_SUCCESS;
%           break;
%       end
%   end
%   
%   % Compute merit parameter (sets merit_parameter and model_reduction)
%   S.strategies_.meritParameterComputation.computeMeritParameter(S.options_,S.quantities_,S.reporter_,S.strategies_);
%   
%   % Print merit parameter values
%   S.strategies_.meritParameterComputation.printIterationValues(S.quantities_,S.reporter_);
%   
%   % Compute stepsize (sets stepsize AND trial_iterate)
%   S.strategies_.stepsizeComputation.computeStepsize(S.options_,S.quantities_,S.reporter_,S.strategies_);
%   
%   % Print stepsize values
%   S.strategies_.stepsizeComputation.printIterationValues(S.quantities_,S.reporter_);
%   
%   % Update current iterate to trial iterate
%   S.quantities_.updateIterate;
%   
%   % Increment iteration counter
%   S.quantities_.incrementIterationCounter;
%   
%   % Print new line
%   S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
%   
% end % main loop
% 
% % Print new line
% S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
% 
% % Print footer
% S.printFooter;
% 
end % optimize