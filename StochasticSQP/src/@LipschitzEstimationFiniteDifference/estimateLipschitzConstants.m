% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% LipschitzEstimationFiniteDifference: estimateLipschitzConstants
function estimateLipschitzConstants(L,options,quantities,reporter,strategies)


% Set Lipschitz Constants
if quantities.iterationCounter <= L.FD_Lipschitz_estimate_iter_first_ ...
        || mod(quantities.iterationCounter - L.FD_Lipschitz_estimate_iter_first_ , L.FD_Lipschitz_estimate_iter_later_) == 0
    
    % Initialize Lipschitz constants
    objectiveLipschitz = 1;
    constraintsLipschitz = sparse(quantities.currentIterate.numberOfConstraintsEqualities,1);
    
    if L.FD_full_samples_
        for i = 1:quantities.currentIterate.numberOfVariables
            sampleIterate = quantities.currentIterate.primalPoint;
            sampleIterate(i) = sampleIterate(i) + L.FD_Lipschitz_estimate_sample_distance_;
            [objectiveLipschitz, constraintsLipschitz] = computeLipschitzConstants(quantities,sampleIterate,objectiveLipschitz,constraintsLipschitz);
        end
    else
        sampleIterate = quantities.currentIterate.primalPoint + L.FD_Lipschitz_estimate_sample_distance_ * sparse(randn(quantities.currentIterate.numberOfVariables,1));
        [objectiveLipschitz, constraintsLipschitz] = computeLipschitzConstants(quantities,sampleIterate,objectiveLipschitz,constraintsLipschitz);
    end
    
    % Compute Lipschitz constants for Jacobian
    constraintsLipschitz = sum(constraintsLipschitz);
    
    % Set Lipschitz Constants
    quantities.setLipschitzConstants(objectiveLipschitz,constraintsLipschitz);
    
end

end % estimateLipschitzConstants

function [objectiveLipschitz, constraintsLipschitz] = computeLipschitzConstants(quantities,sampleIterate,objectiveLipschitz,constraintsLipschitz)

[f_scale,cE_scale,~] = quantities.currentIterate.scaleFactors;
sampleTrueObjectiveGradient = f_scale * quantities.currentIterate.problem.evaluateObjectiveGradient(sampleIterate,'true');
sampleJacobian = cE_scale .* quantities.currentIterate.problem.evaluateConstraintJacobianEqualities(sampleIterate);
objectiveLipschitz = max(objectiveLipschitz , norm(quantities.currentIterate.objectiveGradient(quantities,'true') - sampleTrueObjectiveGradient) / norm(sampleIterate - quantities.currentIterate.primalPoint));
constraintsLipschitz = max(constraintsLipschitz, vecnorm(quantities.currentIterate.constraintJacobianEqualities(quantities)' - sampleJacobian')' / norm(sampleIterate - quantities.currentIterate.primalPoint));

end