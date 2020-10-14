% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'SCA_stepsize_diminishing',false);

% Add double options
options.addDoubleOption(reporter,'SCA_objective_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCA_constraint_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCA_projection_width',1e+04,0,inf);
options.addDoubleOption(reporter,'SCA_stepsize_scaling',1e+00,0,inf);
options.addDoubleOption(reporter,'SCA_sufficient_decrease',1e-01,0,inf);

end % addOptions