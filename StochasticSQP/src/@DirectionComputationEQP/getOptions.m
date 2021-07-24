% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationEQP: getOptions
function getOptions(D,options,reporter)

% Get options
D.cg_iteration_relative_limit_ = options.getOption(reporter,'DCEQP_cg_iteration_relative_limit');
D.cg_residual_tolerance_ = options.getOption(reporter,'DCEQP_cg_residual_tolerance');
D.cg_trust_region_factor_ = options.getOption(reporter,'DCEQP_cg_trust_region_factor');
D.compute_true_ = options.getOption(reporter,'DCEQP_compute_true');
D.constraint_reduction_tolerance_ = options.getOption(reporter,'DCEQP_constraint_reduction_tolerance');
D.constraint_regularization_ = options.getOption(reporter,'DCEQP_constraint_regularization');
D.curvature_threshold_ = options.getOption(reporter,'DCEQP_curvature_threshold');
D.decompose_step_ = options.getOption(reporter,'DCEQP_decompose_step');
D.decomposition_threshold_ = options.getOption(reporter,'DCEQP_decomposition_threshold');
D.model_reduction_tolerance_constraints_ = options.getOption(reporter,'DCEQP_model_reduction_tolerance_constraints');
D.model_reduction_tolerance_objective_ = options.getOption(reporter,'DCEQP_model_reduction_tolerance_objective');
D.modification_factor_ = options.getOption(reporter,'DCEQP_modification_factor');
D.modification_limit_ = options.getOption(reporter,'DCEQP_modification_limit');
D.residual_dual_tolerance_ = options.getOption(reporter,'DCEQP_residual_dual_tolerance');
D.residual_tolerance_factor_ = options.getOption(reporter,'DCEQP_residual_tolerance_factor');
D.residual_tolerance_minimum_ = options.getOption(reporter,'DCEQP_residual_tolerance_minimum');
D.stationarity_imbalance_tolerance_ = options.getOption(reporter,'DCEQP_stationarity_imbalance_tolerance');
D.stepsize_residual_dual_tolerance_ = options.getOption(reporter,'DCEQP_stepsize_residual_dual_tolerance');
D.stepsize_residual_primal_tolerance_ = options.getOption(reporter,'DCEQP_stepsize_residual_primal_tolerance');
D.tangential_objective_tolerance_ = options.getOption(reporter,'DCEQP_tangential_objective_tolerance');
D.termination_test_iteration_frequency_ = options.getOption(reporter,'DCEQP_termination_test_iteration_frequency');
D.termination_test_iteration_minimum_ = options.getOption(reporter,'DCEQP_termination_test_iteration_minimum');
D.use_hessian_of_lagrangian_ = options.getOption(reporter,'DCEQP_use_hessian_of_lagrangian');
D.use_iterative_solver_ = options.getOption(reporter,'DCEQP_use_iterative_solver');

end % getOptions