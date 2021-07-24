% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ParameterComputationModelReduction: getOptions
function getOptions(P,options,reporter)

% Get options
P.curvature_threshold_ = options.getOption(reporter,'PCMR_curvature_threshold');
P.model_increase_factor_ = options.getOption(reporter,'PCMR_model_increase_factor');
P.model_reduction_factor_ = options.getOption(reporter,'PCMR_model_reduction_factor');
P.parameter_increase_factor_ = options.getOption(reporter,'PCMR_parameter_increase_factor');
P.parameter_minimum_ = options.getOption(reporter,'PCMR_parameter_minimum');
P.parameter_reduction_factor_ = options.getOption(reporter,'PCMR_parameter_reduction_factor');
P.quadratic_model_for_merit_update_ = options.getOption(reporter,'PCMR_quadratic_model_for_merit_update');
P.quadratic_model_for_stepsize_ = options.getOption(reporter,'PCMR_quadratic_model_for_stepsize');

end % getOptions