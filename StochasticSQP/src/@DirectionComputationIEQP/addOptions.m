% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationIEQP: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'DCIEQP_use_hessian_of_lagrangian',false);
options.addDoubleOption(reporter,'DCIEQP_full_residual_norm_factor',1e-01,0,1);
options.addDoubleOption(reporter,'DCIEQP_primal_residual_norm_factor',1e-01,0,Inf);
options.addDoubleOption(reporter,'DCIEQP_dual_residual_norm_factor',1e-01,0,1); % should also depend on model_reduction_factor...
options.addDoubleOption(reporter,'DCIEQP_constraint_norm_factor',1e-01,0,1); % should also depend on full_residual_norm_factor
options.addDoubleOption(reporter,'DCIEQP_lagrangian_primal_norm_factor',1e-01,0,1);
options.addDoubleOption(reporter,'DCIEQP_curvature_threshold',1e-08,0,inf); % Have another copy in MCMRI class...
options.addDoubleOption(reporter,'DCIEQP_model_reduction_factor',1e-01,0,1); % Have another copy in MCMRI class...


end % addOptions