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
%   S = StochasticSQP
%
% Public methods:
%
%   S.optimize(problem)
%       Runs optimization algorithm.
%
%   [x,y] = S.solution
%       Returns solution estimate.

% StochasticSQP class
classdef StochasticSQP < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Members %
    %%%%%%%%%%%
    options_
    quantities_
    reporter_
    status_
    strategies_
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function S = StochasticSQP
      
      % Set options
      S.options_ = Options;
      
      % Set quantities
      S.quantities_ = Quantities;
      
      % Set reporter
      S.reporter_ = Reporter;
      
      % Set strategies
      S.strategies_ = Strategies;
      
      % Add options
      S.addOptions;
      
    end % Constructor
    
    %%%%%%%%%%%%
    % OPTIMIZE %
    %%%%%%%%%%%%
    
    % Optimize
    optimize(S,problem)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Solution
    [x,y] = solution(S)
    
  end % methods (public access)
  
  % Methods (private access)
  methods (Access = private)
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print footer
    printFooter(S)
    
    % Print header
    printHeader(S)
    
    % Print iteration header
    printIterationHeader(S)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(S)
    
    % Get options
    getOptions(S)
    
  end % methods (private access)
  
end % StochasticSQP