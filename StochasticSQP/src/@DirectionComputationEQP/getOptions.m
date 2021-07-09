% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationEQP: getOptions
function getOptions(D,options,reporter)

% Get options
D.cg_iteration_limit_ = options.getOption(reporter,'DCEQP_cg_iteration_limit');
D.cg_residual_tolerance_ = options.getOption(reporter,'DCEQP_cg_residual_tolerance');
D.cg_trust_region_factor_ = options.getOption(reporter,'DCEQP_cg_trust_region_factor');
D.compute_true_ = options.getOption(reporter,'DCEQP_compute_true');
D.curvature_threshold_ = options.getOption(reporter,'DCEQP_curvature_threshold');
D.decompose_step_ = options.getOption(reporter,'DCEQP_decompose_step');
D.use_hessian_of_lagrangian_ = options.getOption(reporter,'DCEQP_use_hessian_of_lagrangian');
D.use_iterative_solver_ = options.getOption(reporter,'DCEQP_use_iterative_solver');

end % getOptions