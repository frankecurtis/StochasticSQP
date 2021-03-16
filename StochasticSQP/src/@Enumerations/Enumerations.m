% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Enumerations class
classdef Enumerations < uint8
  
  enumeration
    
    %%%%%%%%%%%%%%%%%%
    % REPORTER TYPES %
    %%%%%%%%%%%%%%%%%%
    R_SOLVER (0)
    R_SUBSOLVER (1)

    %%%%%%%%%%%%%%%%%%%
    % REPORTER LEVELS %
    %%%%%%%%%%%%%%%%%%%
    R_BASIC (0)
    R_PER_ITERATION (1)
    R_PER_INNER_ITERATION (2)
    R_DETAILED (3)
    
    %%%%%%%%%%%%%%%%%%%
    % SOLVER STATUSES %
    %%%%%%%%%%%%%%%%%%%
    S_UNSET (0)
    S_SUCCESS (1)
    S_SIZE_LIMIT (2)
    S_ITERATION_LIMIT (3)
    S_INNER_ITERATION_LIMIT (4)
    S_DIRECTION_COMPUTATION_FAILURE (5)
    S_CPU_TIME_LIMIT (6)
    S_OPTIMALITY_PROGRESS_FAILURE (7)
    S_FEASIBILITY_PROGRESS_FAILURE (8)

  end % enumeration
  
end % Enumerations