% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReductionInexact: getOptions
function getOptions(M,options,reporter)

% Get options
M.curvature_threshold_ = options.getOption(reporter,'MCMRI_curvature_threshold');
M.model_reduction_factor_ = options.getOption(reporter,'MCMRI_model_reduction_factor');
M.parameter_reduction_factor_ = options.getOption(reporter,'MCMRI_parameter_reduction_factor');
% M.dual_residual_norm_factor_ = options.getOption(reporter,'MCMRI_dual_residual_norm_factor');

end % getOptions