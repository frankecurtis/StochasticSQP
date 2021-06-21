% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationEQPInexact: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'DCEQPI_use_hessian_of_lagrangian',false);
options.addDoubleOption(reporter,'DCEQPI_full_residual_norm_factor',1e-01,0,1);
options.addDoubleOption(reporter,'DCEQPI_primal_residual_norm_factor',1e-01,0,Inf);
options.addDoubleOption(reporter,'DCEQPI_dual_residual_norm_factor',1e-01,0,1);
options.addDoubleOption(reporter,'DCEQPI_constraint_norm_factor',1e-01,0,1);
options.addDoubleOption(reporter,'DCEQPI_lagrangian_primal_norm_factor',1e-01,0,1);
options.addDoubleOption(reporter,'DCEQPI_curvature_threshold',1e-08,0,inf);
options.addDoubleOption(reporter,'DCEQPI_model_reduction_factor',1e-01,0,1);

end % addOptions