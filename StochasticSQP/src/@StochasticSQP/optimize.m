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

% Estimate Lipschitz Constants
currentIterate = S.quantities_.currentIterate.primalPoint;
currentObjectiveGradient = S.quantities_.currentIterate.objectiveGradient(S.quantities_);
currentJacobian = S.quantities_.currentIterate.constraintJacobianEqualities(S.quantities_);
n = S.quantities_.currentIterate.numberOfVariables;
m = S.quantities_.currentIterate.numberOfConstraintsEqualities;
objectiveLipschitz = 1;
constraintsLipschitz = zeros(m,1);
for i = 1:n
    
    sampleIterate = currentIterate;
    sampleIterate(i) = sampleIterate(i) + 1e-4;
    [f_scale,cE_scale,~] = S.quantities_.currentIterate.scaleFactors;
    sampleObjectiveGradient = f_scale * problem.evaluateObjectiveGradient(sampleIterate);
    sampleJacobian = cE_scale .* problem.evaluateConstraintJacobianEqualities(sampleIterate);
    
    % Update Lipschitz estimates
    objectiveLipschitz = max(objectiveLipschitz , 1e+4 * norm(currentObjectiveGradient - sampleObjectiveGradient));
    for j = 1:m
        constraintsLipschitz(j) = max(constraintsLipschitz(j) , 1e+4 * norm(currentJacobian(j,:) - sampleJacobian(j,:)));
    end
    
end

constraintsLipschitz = sum(constraintsLipschitz);

% Set Lipschitz Constants
S.quantities_.setLipschitzConstants(objectiveLipschitz,constraintsLipschitz);

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
  
  % Check for termination
  if S.quantities_.currentIterate.numberOfVariables + ...
      S.quantities_.currentIterate.numberOfConstraintsEqualities + ...
      S.quantities_.currentIterate.numberOfConstraintsInequalities >= ...
      S.quantities_.sizeLimit
    S.status_ = Enumerations.S_SIZE_LIMIT;
    break;
  end
  if S.quantities_.iterationCounter >= S.quantities_.iterationLimit
    S.status_ = Enumerations.S_ITERATION_LIMIT;
    break;
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
  
  % Check for termination
  if S.quantities_.currentIterate.stationarityMeasure(S.quantities_) <= S.quantities_.stationarityTolerance
    S.status_ = Enumerations.S_SUCCESS;
    break;
  end
  
  % Compute merit parameter (sets merit_parameter and model_reduction)
  S.strategies_.meritParameterComputation.computeMeritParameter(S.options_,S.quantities_,S.reporter_,S.strategies_);
  
  % Print merit parameter values
  S.strategies_.meritParameterComputation.printIterationValues(S.quantities_,S.reporter_);
  
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