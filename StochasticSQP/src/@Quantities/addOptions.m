% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% Quantities: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'check_derivatives',false);
options.addBoolOption(reporter,'scale_problem',true);
options.addBoolOption(reporter,'stepsize_diminishing',false);

% Add integer options
options.addIntegerOption(reporter,'batch_size',1,0,inf);
options.addIntegerOption(reporter,'constraint_function_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'constraint_Jacobian_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'hessian_of_lagrangian_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'iteration_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'matrix_factorization_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'objective_function_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'objective_gradient_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'objective_gradient_true_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'size_limit',1e+06,0,inf);

% Add double options
options.addDoubleOption(reporter,'cg_iteration_relative_limit',1e+04,0,inf);
options.addDoubleOption(reporter,'cpu_time_limit',1800,0,inf);
options.addDoubleOption(reporter,'curvature_parameter_initial',1e-01,0,inf);
options.addDoubleOption(reporter,'decomposition_parameter_initial',1e-01,0,inf);
options.addDoubleOption(reporter,'feasibility_tolerance',1e-06,0,inf);
options.addDoubleOption(reporter,'kkt_error_tolerance',1e-04,0,inf);
options.addDoubleOption(reporter,'minres_iteration_relative_limit',1e+04,0,inf);
options.addDoubleOption(reporter,'merit_parameter_initial',1e-01,0,inf);
options.addDoubleOption(reporter,'ratio_parameter_initial',1e+00,0,inf);
options.addDoubleOption(reporter,'scale_factor_gradient_limit',1e+02,0,inf);
options.addDoubleOption(reporter,'stepsize_scaling_initial',1e+00,0,inf);

end % addOptions