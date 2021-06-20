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
%   Optimization." SIAM Journal on Optimization, 31(2):1352-1379, 2021.
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
%   [x,yE,yI,infeasibility,stationarity] = bestIterate(S)
%       Returns best iterate.
%
%   [x,yE,yI,infeasibility,stationarity] = finalIterate(S)
%       Returns final iterate.
%
%   o = options(S)
%       Returns options object.
%
%   r = reporter(S)
%       Returns reporter object.

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
    
    % Best iterate
    function [x,yE,yI,infeasibility,stationarity] = bestIterate(S)
      
      % Set return values
      x = S.quantities_.bestIterate.primalPoint;
      [yE,yI] = S.quantities_.bestIterate.multipliers('stochastic');
      infeasibility = S.quantities_.bestIterate.constraintNormInf(S.quantities_);
      stationarity = S.quantities_.bestIterate.stationarityMeasure(S.quantities_,'stochastic');
      
    end % solution
    
    % Final iterate
    function [x,yE,yI,infeasibility,stationarity] = finalIterate(S)
      
      % Set return values
      x = S.quantities_.currentIterate.primalPoint;
      [yE,yI] = S.quantities_.currentIterate.multipliers('stochastic');
      infeasibility = S.quantities_.currentIterate.constraintNormInf(S.quantities_);
      stationarity = S.quantities_.currentIterate.stationarityMeasure(S.quantities_,'stochastic');
      
    end % finalIterate
    
    % Options
    function o = options(S)
      
      % Set return value
      o = S.options_;
      
    end % options
    
    % Reporter
    function r = reporter(S)
      
      % Set return value
      r = S.reporter_;
      
    end % reporter
    
  end % methods (public access)
  
  % Methods (private access)
  methods (Access = private)
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print footer
    printFooter(S)
    
    % Print header
    printHeader(S,P)
    
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