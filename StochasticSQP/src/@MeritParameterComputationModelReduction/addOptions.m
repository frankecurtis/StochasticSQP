% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% MeritParameterComputationModelReduction: addOptions
function addOptions(options,reporter)

% Add options
options.addDoubleOption(reporter,'MCMR_curvature_threshold',1e-08,0,inf);
options.addDoubleOption(reporter,'MCMR_model_reduction_factor',1e-01,0,1);
options.addDoubleOption(reporter,'MCMR_parameter_reduction_factor',1e-02,0,1);

end % addOptions