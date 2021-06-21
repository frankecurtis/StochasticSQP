% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationEQP: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'DCEQP_compute_true',false);
options.addBoolOption(reporter,'DCEQP_decompose_step',true);
options.addBoolOption(reporter,'DCEQP_use_hessian_of_lagrangian',false);

% Add double options
options.addDoubleOption(reporter,'DCEQP_cg_iteration_limit',0.99,0,inf);
options.addDoubleOption(reporter,'DCEQP_cg_residual_tolerance',1e-08,0,inf);
options.addDoubleOption(reporter,'DCEQP_cg_trust_region_factor',1e+04,0,inf);
options.addDoubleOption(reporter,'DCEQP_curvature_threshold',1e-08,0,inf);

end % addOptions