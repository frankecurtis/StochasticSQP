% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StepsizeComputationAdaptive: addOptions
function addOptions(options,reporter)

% Add options
options.addDoubleOption(reporter,'SCA_objective_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCA_constraint_Lipschitz',1e+02,0,inf);
options.addDoubleOption(reporter,'SCA_sufficient_decrease',1e-01,0,inf);

end % addOptions