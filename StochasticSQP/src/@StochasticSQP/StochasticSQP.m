% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% StochasticSQP
%
% Please cite:
%
%   A. S. Berahas, F. E. Curtis, D. P. Robinson, and B. Zhou.  "Sequential
%   Quadratic Optimization for Nonlinear Equality Constrained Stochastic
%   Optimization." arXiv, 2007.10525.  2020.
%
% Constructors:
%
%   S = StochasticSQP()
%
% Public methods:
%
%   [x,y] = S.solution()
%       Returns solution estimate.
%
%   S.optimize()
%       Runs optimization algorithm.

% Stochastic SQP class
classdef StochasticSQP < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Members %
    %%%%%%%%%%%
    options
    iterate
    problem
    strategies
    
    %%%%%%%%%%%
    % Options %
    %%%%%%%%%%%
    scale_problem
    iteration_limit
    stationarity_tolerance
    scale_factor_gradient_limit
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function S = StochasticSQP(varargin)
      
      % Set options
      S.options = Options;
      
      % Add options
      S.addOptions;
      
    end
    
    % Optimize
    optimize(S,problem)
    
  end
  
  % Methods (private access)
  methods (Access = private)

    % Add options
    addOptions(S)
    
    % Get options
    getOptions(S)
        
  end
  
  % Methods (static)
  methods (Static)
    
  end
  
end