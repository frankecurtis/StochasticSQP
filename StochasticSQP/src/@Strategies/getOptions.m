% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Strategies: getOptions
function getOptions(S,options,reporter)

% Get strategies options
direction_computation_name = options.getOption(reporter,'direction_computation');
lipschitz_estimation_name = options.getOption(reporter,'lipschitz_estimation');
parameter_computation_name = options.getOption(reporter,'parameter_computation');
stepsize_computation_name = options.getOption(reporter,'stepsize_computation');

% Switch on direction computation names
switch direction_computation_name
  case 'EQP'
    S.direction_computation_ = DirectionComputationEQP;
  case 'IQP'
    S.direction_computation_ = DirectionComputationIQP;
  case 'EQPInexact'
    S.direction_computation_ = DirectionComputationEQPInexact;
  case 'Subgradient'
    S.direction_computation_ = DirectionComputationSubgradient;
  otherwise
    S.direction_computation_ = DirectionComputationEQP;
end

% Switch on lipschitz estimation names
switch lipschitz_estimation_name
  case 'FiniteDifference'
    S.lipschitz_estimation_ = LipschitzEstimationFiniteDifference;
  otherwise
    S.lipschitz_estimation_ = LipschitzEstimationFiniteDifference;
end

% Switch on merit parameter computation names
switch parameter_computation_name
  case 'Fixed'
    S.parameter_computation_ = ParameterComputationFixed;
  case 'ModelReduction'
    S.parameter_computation_ = ParameterComputationModelReduction;
  otherwise
    S.parameter_computation_ = ParameterComputationModelReduction;
end

% Switch on stepsize computation names
switch stepsize_computation_name
  case 'Adaptive'
    S.stepsize_computation_ = StepsizeComputationAdaptive;
  case 'Conservative'
    S.stepsize_computation_ = StepsizeComputationConservative;
  otherwise
    S.stepsize_computation_ = StepsizeComputationAdaptive;
end

% Get options
S.direction_computation_.getOptions(options,reporter);
S.lipschitz_estimation_.getOptions(options,reporter);
S.parameter_computation_.getOptions(options,reporter);
S.stepsize_computation_.getOptions(options,reporter);

end % getOptions