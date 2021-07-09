% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StochasticSQP: optimize
function optimize(S,problem)

% Get options
S.getOptions;

% Initialize quantities
S.quantities_.initialize(problem);

% Scale problem
S.quantities_.currentIterate.determineScaleFactors(S.quantities_,'stochastic');

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
  if S.quantities_.stationaritySatisfied, S.status_ = Enumerations.S_SUCCESS; break; end

  % Check for CPU time termination
  if S.quantities_.limitExceededCPU, S.status_ = Enumerations.S_CPU_TIME_LIMIT; break; end
  
  % Check for termination on problem size limit
  if S.quantities_.limitExceededSize, S.status_ = Enumerations.S_SIZE_LIMIT; break; end
  
  % Check for termination on iteration limit
  if S.quantities_.limitExceededIterations, S.status_ = Enumerations.S_ITERATION_LIMIT; break; end
  
  % Check for termination on evaluation limit
  if S.quantities_.limitExceededEvaluations, S.status_ = Enumerations.S_EVALUATION_LIMIT; break; end
  
  % Compute search direction (sets direction)
  err = S.strategies_.directionComputation.computeDirection(S.options_,S.quantities_,S.reporter_,S.strategies_);
  
  % Check for error
  if err == true, S.status_ = Enumerations.S_DIRECTION_COMPUTATION_FAILURE; break; end
  
  % Print direction computation values
  S.strategies_.directionComputation.printIterationValues(S.quantities_,S.reporter_);
  
  % Compute parameters (sets merit_parameter, ratio_parameter, decomposition_parameter, curvature_parameter, and model_reduction)
  S.strategies_.parameterComputation.computeParameters(S.options_,S.quantities_,S.reporter_,S.strategies_);
  
  % Print parameter values
  S.strategies_.parameterComputation.printIterationValues(S.quantities_,S.reporter_);
  
  % Estimate Lipschitz constants (sets Lipschitz constants)
  S.strategies_.lipschitzEstimation.estimateLipschitzConstants(S.options_,S.quantities_,S.reporter_,S.strategies_);
  
  % Print Lipschitz constants
  S.strategies_.lipschitzEstimation.printIterationValues(S.quantities_,S.reporter_);
  
  % Compute stepsize (sets stepsize and trial_iterate)
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