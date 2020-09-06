% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Quantities: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'scale_problem',true);
options.addDoubleOption(reporter,'cpu_time_limit',600,0,inf);
options.addDoubleOption(reporter,'merit_parameter_initial',1e-01,0,inf);
options.addDoubleOption(reporter,'scale_factor_gradient_limit',1e+02,0,inf);
options.addDoubleOption(reporter,'stationarity_tolerance',1e-04,0,inf);
options.addIntegerOption(reporter,'constraint_function_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'constraint_Jacobian_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'objective_function_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'objective_gradient_evaluation_limit',1e+03,0,inf);
options.addIntegerOption(reporter,'iteration_limit',1e+03,0,inf);

end % addOptions