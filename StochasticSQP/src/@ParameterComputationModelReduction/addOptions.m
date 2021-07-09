% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% ParameterComputationModelReduction: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'PCMR_quadratic_model_for_merit_update',true);
options.addBoolOption(reporter,'PCMR_quadratic_model_for_stepsize',false);

% Add double options
options.addDoubleOption(reporter,'PCMR_curvature_threshold',1e-08,0,inf);
options.addDoubleOption(reporter,'PCMR_model_increase_factor',1e+00,0,1);
options.addDoubleOption(reporter,'PCMR_model_reduction_factor',1e-01,0,1);
options.addDoubleOption(reporter,'PCMR_parameter_reduction_factor',1e-02,0,1);

end % addOptions