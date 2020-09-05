% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Stochastic SQP: optimize
function optimize(S,problem)

% Get global variables
global R_SOLVER R_PER_ITERATION

% Set problem
S.problem = problem;

% Get options
S.getOptions;

% Initialize quantities
S.quantities.initialize(S.problem);

% Determine scale factors
S.quantities.currentIterate.determineScaleFactors(S.scale_factor_gradient_limit);

% Print header
S.printHeader;

% Main loop
while true
  
  % Print iterate information
  S.reporter.printf(R_SOLVER,R_PER_ITERATION,'%6d %+e %+e %+e\n',...
                    S.quantities.iterationCounter,...
                    S.quantities.currentIterate.objectiveFunction,...
                    S.quantities.currentIterate.objectiveGradientNormInf,...
                    S.quantities.currentIterate.constraintNormInf);
  
  % Check for termination
  if S.quantities.iterationCounter >= S.iteration_limit, break; end
  
  % Compute search direction
  S.quantities.setTrialIterate(S.quantities.currentIterate.makeLinearCombination(10.0/(S.quantities.iterationCounter+1),-S.quantities.currentIterate.objectiveGradient));
  
  % Set current iterate to trial iterate
  S.quantities.updateIterate;

  % Increment iteration counter
  S.quantities.incrementIterationCounter;
    
end

% Print footer
S.printFooter;

end