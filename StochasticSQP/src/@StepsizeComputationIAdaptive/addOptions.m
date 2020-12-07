% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationIAdaptive: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'SCIA_stepsize_diminishing',false);

% Add double options
options.addDoubleOption(reporter,'SCIA_objective_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCIA_constraint_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCIA_projection_width',1e+04,0,inf);
options.addDoubleOption(reporter,'SCIA_stepsize_scaling',1e+00,0,inf);
options.addDoubleOption(reporter,'SCIA_sufficient_decrease',5e-01,0,inf);
options.addDoubleOption(reporter,'SCIA_forward_lengthening',1e+00,1,inf);

end % addOptions