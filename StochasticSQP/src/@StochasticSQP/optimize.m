% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StochasticSQP: optimize
function optimize(S,problem)

% Use random seed
rng(0);

% Get options
S.getOptions;

% Initialize quantities
S.quantities_.initialize(problem);

% Scale problem
S.quantities_.currentIterate.determineScaleFactors(S.quantities_);

% Initialize strategies
S.strategies_.initialize(S.options_,S.quantities_,S.reporter_);

% Print header
S.printHeader(problem);

% Main loop
while true
    
    % Print iteration header
    S.printIterationHeader;
    
    % Print iteration quantities
    S.quantities_.printIterationValues(S.reporter_);
    
    % Check for termination of best iterate
    if S.quantities_.bestIterate.constraintNormInf(S.quantities_) <= S.quantities_.feasibilityTolerance
        if S.quantities_.bestIterate.stationarityMeasure(S.quantities_,true) <= S.quantities_.stationarityTolerance
            S.status_ = Enumerations.S_SUCCESS;
            break;
        end
    end
    
    % Check for CPU time termination
    if S.quantities_.CPUTime >= S.quantities_.CPUTimeLimit
        S.status_ = Enumerations.S_CPU_TIME_LIMIT;
        break;
    end
    
    % Check for termination on problem size limit
    if S.quantities_.currentIterate.numberOfVariables + ...
            S.quantities_.currentIterate.numberOfConstraintsEqualities + ...
            S.quantities_.currentIterate.numberOfConstraintsInequalities > ...
            S.quantities_.sizeLimit
        S.status_ = Enumerations.S_SIZE_LIMIT;
        break;
    end
    
    % Check for termination on outer iteration limit
    if S.quantities_.iterationCounter > S.quantities_.iterationLimit
        S.status_ = Enumerations.S_ITERATION_LIMIT;
        break;
    end
    
    % Check for termination on inner iteration limit when necessary
    switch S.options_.getOption(S.reporter_,'direction_computation')
        case 'IEQP'
            if S.quantities_.innerIterationCounter >= S.quantities_.innerIterationRelativeLimit * ...
                    (S.quantities_.currentIterate.numberOfVariables + S.quantities_.currentIterate.numberOfConstraintsEqualities + S.quantities_.currentIterate.numberOfConstraintsInequalities)
                S.status_ = Enumerations.S_ITERATION_LIMIT;
                break;
            end
    end
    
    % Compute search direction (sets direction)
    err = S.strategies_.directionComputation.computeDirection(S.options_,S.quantities_,S.reporter_,S.strategies_);
    
    % Check for error
    if err == true
        S.status_ = Enumerations.S_DIRECTION_COMPUTATION_FAILURE;
        break;
    end
    
    % Print direction computation values
    S.strategies_.directionComputation.printIterationValues(S.quantities_,S.reporter_);
    
    % Compute merit parameter (sets merit_parameter and model_reduction)
    S.strategies_.meritParameterComputation.computeMeritParameter(S.options_,S.quantities_,S.reporter_,S.strategies_);
    
    % Print merit parameter values
    S.strategies_.meritParameterComputation.printIterationValues(S.quantities_,S.reporter_);
    
    % Estimate Lipschitz constant (sets Lipschitz constants)
    S.strategies_.LipschitzEstimation.estimateLipschitzConstants(S.options_,S.quantities_,S.reporter_,S.strategies_);
    
    % Print Lipschitz constants
    S.strategies_.LipschitzEstimation.printIterationValues(S.quantities_,S.reporter_);
    
    % Compute stepsize (sets stepsize AND trial_iterate)
    S.strategies_.stepsizeComputation.computeStepsize(S.options_,S.quantities_,S.reporter_,S.strategies_);
    
    % Print stepsize values
    S.strategies_.stepsizeComputation.printIterationValues(S.quantities_,S.reporter_);
    
    % Update current iterate to trial iterate
    S.quantities_.updateIterate;
    
    % Increment iteration counter
    S.quantities_.incrementIterationCounter;
    
    % Print new line
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
    
end % main loop

% Print new line
S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');

% Print footer
S.printFooter;

end % optimize