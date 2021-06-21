% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Strategies: getOptions
function getOptions(S,options,reporter)

% Get strategies options
direction_computation_name = options.getOption(reporter,'direction_computation');
lipschitz_estimation_name = options.getOption(reporter,'lipschitz_estimation');
merit_parameter_computation_name = options.getOption(reporter,'merit_parameter_computation');
stepsize_computation_name = options.getOption(reporter,'stepsize_computation');

% Switch on direction computation names
switch direction_computation_name
  case 'EQP'
    S.direction_computation_ = DirectionComputationEQP;
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
switch merit_parameter_computation_name
  case 'Fixed'
    S.merit_parameter_computation_ = MeritParameterComputationFixed;
  case 'ModelReduction'
    S.merit_parameter_computation_ = MeritParameterComputationModelReduction;
  otherwise
    S.merit_parameter_computation_ = MeritParameterComputationModelReduction;
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
S.merit_parameter_computation_.getOptions(options,reporter);
S.stepsize_computation_.getOptions(options,reporter);

end % getOptions