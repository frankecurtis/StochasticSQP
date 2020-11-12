% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: addOptions
function addOptions(options,reporter)

% Add options
options.addDoubleOption(reporter,'MCMRI_curvature_threshold',1e-08,0,inf); % Have another copy in DCIEQP class...
options.addDoubleOption(reporter,'MCMRI_model_reduction_factor',1e-01,0,1); % Have another copy in DCIEQP class...
options.addDoubleOption(reporter,'MCMRI_parameter_reduction_factor',1e-02,0,1);
options.addDoubleOption(reporter,'MCMRI_dual_residual_norm_factor',1e-01,0,1); % should also depend on model_reduction_factor... % Have another copy in DCIEQP class...

end % addOptions