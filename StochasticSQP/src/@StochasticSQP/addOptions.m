% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% StochasticSQP: addOptions
function addOptions(S)

% Add options from quantities
S.quantities_.addOptions(S.options_,S.reporter_);

% Add options from strategies
S.strategies_.addOptions(S.options_,S.reporter_);

end % addOptions