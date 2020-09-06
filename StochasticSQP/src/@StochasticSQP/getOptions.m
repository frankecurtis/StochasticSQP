% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StochasticSQP: getOptions
function getOptions(S)

% Get options for quantities
S.quantities_.getOptions(S.options_,S.reporter_);

% Get options for strategies
S.strategies_.getOptions(S.options_,S.reporter_);

end % getOptions