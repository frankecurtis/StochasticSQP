% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Quantities: getOptions
function getOptions(Q,options,reporter)

% Get options
Q.batch_size_ = options.getOption(reporter,'batch_size');
Q.cg_iteration_relative_limit_ = options.getOption(reporter,'cg_iteration_relative_limit');
Q.compute_stationarity_true_ = options.getOption(reporter,'compute_stationarity_true');
Q.constraint_function_evaluation_limit_ = options.getOption(reporter,'constraint_function_evaluation_limit');
Q.constraint_Jacobian_evaluation_limit_ = options.getOption(reporter,'constraint_Jacobian_evaluation_limit');
Q.cpu_time_limit_ = options.getOption(reporter,'cpu_time_limit');
Q.curvature_parameter_ = options.getOption(reporter,'curvature_parameter_initial');
Q.decomposition_parameter_ = options.getOption(reporter,'decomposition_parameter_initial');
Q.feasibility_tolerance_ = options.getOption(reporter,'feasibility_tolerance');
Q.hessian_of_lagrangian_evaluation_limit_ = options.getOption(reporter,'hessian_of_lagrangian_evaluation_limit');
Q.iteration_limit_ = options.getOption(reporter,'iteration_limit');
Q.kkt_error_tolerance_ = options.getOption(reporter,'kkt_error_tolerance');
Q.merit_parameter_ = options.getOption(reporter,'merit_parameter_initial');
Q.matrix_factorization_limit_ = options.getOption(reporter,'matrix_factorization_limit');
Q.minres_iteration_relative_limit_ = options.getOption(reporter,'minres_iteration_relative_limit');
Q.objective_function_evaluation_limit_ = options.getOption(reporter,'objective_function_evaluation_limit');
Q.objective_gradient_evaluation_limit_ = options.getOption(reporter,'objective_gradient_evaluation_limit');
Q.objective_gradient_true_evaluation_limit_ = options.getOption(reporter,'objective_gradient_true_evaluation_limit');
Q.ratio_parameter_ = options.getOption(reporter,'ratio_parameter_initial');
Q.scale_factor_gradient_limit_ = options.getOption(reporter,'scale_factor_gradient_limit');
Q.scale_problem_ = options.getOption(reporter,'scale_problem');
Q.size_limit_ = options.getOption(reporter,'size_limit');
Q.stepsize_diminishing_ = options.getOption(reporter,'stepsize_diminishing');
Q.stepsize_scaling_initial_ = options.getOption(reporter,'stepsize_scaling_initial');

end % getOptions