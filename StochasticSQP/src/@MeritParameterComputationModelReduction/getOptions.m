% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: getOptions
function getOptions(M,options,reporter)

% Get options
M.curvature_threshold_ = options.getOption(reporter,'MCMR_curvature_threshold');
M.model_reduction_factor_ = options.getOption(reporter,'MCMR_model_reduction_factor');
M.parameter_reduction_factor_ = options.getOption(reporter,'MCMR_parameter_reduction_factor');
M.quadratic_model_for_merit_update_ = options.getOption(reporter,'MCMR_quadratic_model_for_merit_update');
M.quadratic_model_for_stepsize_ = options.getOption(reporter,'MCMR_quadratic_model_for_stepsize');

end % getOptions