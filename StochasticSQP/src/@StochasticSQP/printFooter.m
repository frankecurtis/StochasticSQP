% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StochasticSQP: printFooter
function printFooter(S)

% Print termination message
switch S.status_
  case Enumerations.S_UNSET
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: Status unset!\n\n');
  case Enumerations.S_SUCCESS
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: Stationary point found.\n\n');
  case Enumerations.S_CPU_TIME_LIMIT
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: CPU time limit exceeded.\n\n');
  case Enumerations.S_SIZE_LIMIT
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: Size limit exceeded.\n\n');
  case Enumerations.S_ITERATION_LIMIT
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: Iteration limit exceeded.\n\n');
  case Enumerations.S_EVALUATION_LIMIT
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: Evaluation limit exceeded.\n\n');
  case Enumerations.S_DIRECTION_COMPUTATION_FAILURE
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: Direction computation failure.\n\n');
  otherwise
    S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
      '\nEXIT: Status unknown!\n\n');
end % switch

% Print quantities footer
S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,...
  ['Objective......................... : %+e\n'...
  'Objective (unscaled).............. : %+e\n'...
  'Constraint violation.............. : %+e\n'...
  'Constraint violation (unscaled)... : %+e\n'...
  'KKT error......................... : %+e\n'...
  'KKT error (true).................. : %+e\n\n'...
  'Best Objective.................... : %+e\n'...
  'Best Objective (unscaled)......... : %+e\n'...
  'Best Constraint violation......... : %+e\n'...
  'Best Constraint violation(unscaled): %+e\n'...
  'Best KKT error.................... : %+e\n'...
  'Best KKT error (true)............. : %+e\n\n'...
  'Iterations........................ : %d\n'...
  'CG iterations (normal step)....... : %d\n'...
  'MINRES iterations (full step)..... : %d\n'...
  'Matrix factorizations (full step). : %d\n'...
  'Objective function evaluations.... : %d\n'...
  'Objective gradient evaluations.... : %d\n'...
  'Equality function evaluations..... : %d\n'...
  'Inequality function evaluations... : %d\n'...
  'Equality Jacobian evaluations..... : %d\n'...
  'Inequality Jacobian evaluations... : %d\n\n'...
  'Termination test exact count...... : %d\n'...
  'Termination test 1 count.......... : %d\n'...
  'Termination test 2 count.......... : %d\n\n'...
  'CPU seconds....................... : %d\n'],...
  S.quantities_.currentIterate.objectiveFunction(S.quantities_),...
  S.quantities_.currentIterate.objectiveFunctionUnscaled(S.quantities_),...
  S.quantities_.currentIterate.constraintNormInf(S.quantities_),...
  S.quantities_.currentIterate.constraintNormInfUnscaled(S.quantities_),...
  S.quantities_.currentIterate.KKTError(S.quantities_,'stochastic'),...
  S.quantities_.currentIterate.KKTError(S.quantities_,'true'),...
  S.quantities_.bestIterate.objectiveFunction(S.quantities_),...
  S.quantities_.bestIterate.objectiveFunctionUnscaled(S.quantities_),...
  S.quantities_.bestIterate.constraintNormInf(S.quantities_),...
  S.quantities_.bestIterate.constraintNormInfUnscaled(S.quantities_),...
  S.quantities_.bestIterate.KKTError(S.quantities_,'stochastic'),...
  S.quantities_.bestIterate.KKTError(S.quantities_,'true'),...
  S.quantities_.iterationCounter,...
  S.quantities_.CGIterationCounter,...
  S.quantities_.MINRESIterationCounter,...
  S.quantities_.matrixFactorizationCounter,...
  S.quantities_.objectiveFunctionEvaluationCounter,...
  S.quantities_.objectiveGradientEvaluationCounter,...
  S.quantities_.constraintFunctionEqualitiesEvaluationCounter,...
  S.quantities_.constraintFunctionInequalitiesEvaluationCounter,...
  S.quantities_.constraintJacobianEqualitiesEvaluationCounter,...
  S.quantities_.constraintJacobianInequalitiesEvaluationCounter,...
  S.quantities_.terminationTestCounter(0),...
  S.quantities_.terminationTestCounter(1),...
  S.quantities_.terminationTestCounter(2),...
  S.quantities_.CPUTime);

end % printFooter