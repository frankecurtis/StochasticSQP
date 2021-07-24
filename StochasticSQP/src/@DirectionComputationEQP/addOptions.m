% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationEQP: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'DCEQP_compute_true',false);
options.addBoolOption(reporter,'DCEQP_decompose_step',true);
options.addBoolOption(reporter,'DCEQP_use_hessian_of_lagrangian',false);
options.addBoolOption(reporter,'DCEQP_use_iterative_solver',false);

% Add integer options
options.addIntegerOption(reporter,'DCEQP_modification_limit',10,1,inf);
options.addIntegerOption(reporter,'DCEQP_termination_test_iteration_frequency',1,0,inf);
options.addIntegerOption(reporter,'DCEQP_termination_test_iteration_minimum',0,0,inf);

% Add double options
options.addDoubleOption(reporter,'DCEQP_cg_iteration_relative_limit',1e-01,0,inf);
options.addDoubleOption(reporter,'DCEQP_cg_residual_tolerance',1e-08,0,inf);
options.addDoubleOption(reporter,'DCEQP_cg_trust_region_factor',1e+04,0,inf);
options.addDoubleOption(reporter,'DCEQP_constraint_reduction_tolerance',1-1e-01,0,inf);
options.addDoubleOption(reporter,'DCEQP_constraint_regularization',1e-08,0,inf);
options.addDoubleOption(reporter,'DCEQP_curvature_threshold',1e-08,0,inf);
options.addDoubleOption(reporter,'DCEQP_decomposition_threshold',1e+03,0,inf);
options.addDoubleOption(reporter,'DCEQP_model_reduction_tolerance_constraints',1-1e-08,0,1);
options.addDoubleOption(reporter,'DCEQP_model_reduction_tolerance_objective',1e-08,0,1);
options.addDoubleOption(reporter,'DCEQP_modification_factor',5e-01,0,1);
options.addDoubleOption(reporter,'DCEQP_residual_dual_tolerance',1e-04,0,1);
options.addDoubleOption(reporter,'DCEQP_residual_tolerance_factor',5e-01,0,1);
options.addDoubleOption(reporter,'DCEQP_residual_tolerance_minimum',1e-10,0,inf);
options.addDoubleOption(reporter,'DCEQP_stationarity_imbalance_tolerance',1e-01,0,inf);
options.addDoubleOption(reporter,'DCEQP_stepsize_residual_dual_tolerance',1e+02,0,inf);
options.addDoubleOption(reporter,'DCEQP_stepsize_residual_primal_tolerance',1e+02,0,inf);
options.addDoubleOption(reporter,'DCEQP_tangential_objective_tolerance',1e-01,0,inf);

end % addOptions