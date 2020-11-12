% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationIEQP: getOptions
function getOptions(D,options,reporter)

% Get options
D.use_hessian_of_lagrangian_ = options.getOption(reporter,'DCIEQP_use_hessian_of_lagrangian');
D.full_residual_norm_factor_ = options.getOption(reporter,'DCIEQP_full_residual_norm_factor');
D.primal_residual_norm_factor_ = options.getOption(reporter,'DCIEQP_primal_residual_norm_factor');
D.dual_residual_norm_factor_ = options.getOption(reporter,'DCIEQP_dual_residual_norm_factor');
D.constraint_norm_factor_ = options.getOption(reporter,'DCIEQP_constraint_norm_factor');
D.lagrangian_primal_norm_factor_ = options.getOption(reporter,'DCIEQP_lagrangian_primal_norm_factor');
D.curvature_threshold_ = options.getOption(reporter,'DCIEQP_curvature_threshold');
D.model_reduction_factor_ = options.getOption(reporter,'DCIEQP_model_reduction_factor');


end % getOptions