% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Strategies: printIterationHeader
function printIterationHeader(S,reporter)

% Print iteration header
S.direction_computation_.printIterationHeader(reporter);
S.merit_parameter_computation_.printIterationHeader(reporter);
S.Lipschitz_estimation_.printIterationHeader(reporter);
S.stepsize_computation_.printIterationHeader(reporter);

end % printIterationHeader