% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Quantities: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'scale_problem',true);
options.addBoolOption(reporter,'compute_iterate_stationarity',true);

% Add integer options
options.addIntegerOption(reporter,'constraint_function_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'constraint_Jacobian_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'hessian_of_lagrangian_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'objective_function_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'objective_gradient_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'iteration_limit',1e+08,0,inf);
options.addIntegerOption(reporter,'size_limit',5e+04,0,inf);
options.addIntegerOption(reporter,'termination_test_number',-1,-inf,inf);


% Add double options
options.addDoubleOption(reporter,'cpu_time_limit',1800,0,inf);
options.addDoubleOption(reporter,'merit_parameter_initial',1e-01,0,inf);
options.addDoubleOption(reporter,'scale_factor_gradient_limit',1e+02,0,inf);
options.addDoubleOption(reporter,'feasibility_tolerance',1e-06,0,inf);
options.addDoubleOption(reporter,'stationarity_tolerance',1e-03,0,inf);
options.addDoubleOption(reporter,'ratio_parameter_initial',1e+00,0,inf);
options.addDoubleOption(reporter,'progress_check_iter',20,0,inf);
options.addDoubleOption(reporter,'progress_ratio',1.005,0,inf);
options.addDoubleOption(reporter,'comparison_ratio',3,0,inf);
options.addDoubleOption(reporter,'inner_iteration_relative_limit',5e+02,0,inf);
options.addDoubleOption(reporter,'batch_size',1,0,inf);

end % addOptions