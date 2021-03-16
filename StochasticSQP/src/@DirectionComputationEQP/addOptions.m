% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% DirectionComputationEQP: addOptions
function addOptions(options,reporter)

% Add options
options.addBoolOption(reporter,'DCEQP_use_hessian_of_lagrangian',false);
options.addDoubleOption(reporter,'DCEQP_curvature_threshold',1e-08,0,inf);

end % addOptions