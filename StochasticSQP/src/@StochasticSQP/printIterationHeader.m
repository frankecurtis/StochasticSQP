% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% StochasticSQP: printIterationHeader
function printIterationHeader(S)

% Print iteration header
if mod(S.quantities_.iterationCounter,20) == 0
  S.quantities_.printIterationHeader(S.reporter_);
  S.strategies_.printIterationHeader(S.reporter_);
  S.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
end

end % printIterationHeader