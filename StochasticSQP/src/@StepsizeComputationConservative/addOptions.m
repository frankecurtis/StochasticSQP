% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationConservative: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'SCC_stepsize_diminishing',false);

% Add double options
options.addDoubleOption(reporter,'SCC_objective_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCC_constraint_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCC_stepsize_scaling',1e+00,0,inf);

end % addOptions