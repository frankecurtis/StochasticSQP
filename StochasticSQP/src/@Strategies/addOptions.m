% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Strategies: addOptions
function addOptions(options,reporter)

% Add options
options.addStringOption(reporter,'direction_computation','EQP');
options.addStringOption(reporter,'merit_parameter_computation','ModelReduction');
options.addStringOption(reporter,'stepsize_computation','Adaptive');
options.addStringOption(reporter,'Lipschitz_estimation','FiniteDifference');

% Add direction computation options
d = DirectionComputationEQP;
d.addOptions(options,reporter);
d = DirectionComputationSubgradient;
d.addOptions(options,reporter);
d = DirectionComputationIEQP;
d.addOptions(options,reporter);

% Add merit parameter computation options
m = MeritParameterComputationFixed;
m.addOptions(options,reporter);
m = MeritParameterComputationModelReduction;
m.addOptions(options,reporter);

% Add stepsize computation options
s = StepsizeComputationAdaptive;
s.addOptions(options,reporter);
s = StepsizeComputationConservative;
s.addOptions(options,reporter);

% Add Lipschitz estimation options
l = LipschitzEstimationFiniteDifference;
l.addOptions(options,reporter);

end % addOptions