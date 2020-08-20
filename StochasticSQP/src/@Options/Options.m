% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Options class
classdef Options < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%%%%
    % QUANTITIES %
    %%%%%%%%%%%%%%
    list = {}
            
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor (problem input)
    function O = Options(varargin)
      
      % Do nothing
      
    end % Constructor
    
    % Add bool option
    function addBoolOption(O,name,value)
      
      % Check if name already taken
      if O.nameTaken(name)
        warning('Options: Duplicate name of option (%s)! Refusing to add this one.',name);
        return;
      end
      
      % Create option
      option.name = name;
      option.type = 'bool';
      option.value = value;
      option.lower = [];
      option.upper = [];
      
      % Add option to list
      O.list(length(O.list)+1) = {option};
      
    end

    % Add bool option
    function addDoubleOption(O,name,value,lower,upper)
      
      % Check if name already taken
      if O.nameTaken(name)
        warning('Options: Duplicate name of option (%s)! Refusing to add this one.',name);
        return;
      end
      
      % Create option
      option.name = name;
      option.type = 'double';
      option.value = value;
      option.lower = lower;
      option.upper = upper;
      
      % Add option to list
      O.list(length(O.list)+1) = {option};
      
    end
    
    % Add bool option
    function addIntegerOption(O,name,value,lower,upper)
      
      % Check if name already taken
      if O.nameTaken(name)
        warning('Options: Duplicate name of option (%s)! Refusing to add this one.',name);
        return;
      end
      
      % Create option
      option.name = name;
      option.type = 'integer';
      option.value = value;
      option.lower = lower;
      option.upper = upper;
      
      % Add option to list
      O.list(length(O.list)+1) = {option};
      
    end
    
    % Add bool option
    function addStringOption(O,name,value)
      
      % Check if name already taken
      if O.nameTaken(name)
        warning('Options: Duplicate name of option (%s)! Refusing to add this one.',name);
        return;
      end
      
      % Create option
      option.name = name;
      option.type = 'integer';
      option.value = value;
      option.lower = [];
      option.upper = [];
      
      % Add option to list
      O.list(length(O.list)+1) = {option};
      
    end
    
    % Get option
    function v = getOption(O,name)
      
      % Loop through list
      for i = 1:length(O.list)
        if strcmp(O.list{i}.name,name)
          v = O.list{i}.value;
          break;
        end
      end
      
    end

    % Name taken(?)
    function b = nameTaken(O,name)
      
      % Initialize boolean
      b = false;
            
      % Loop through list to check if name has been taken
      for i = 1:length(O.list)
        if strcmp(O.list{i}.name,name)
          b = true;
        end
      end
      
    end
    
    % Print
    function print(O)
      
      % Loop through list
      for i = 1:length(O.list)
        fprintf('Option %d:\n',i);
        fprintf('  name...: %s\n',O.list{i}.name);
        fprintf('  type...: %s\n',O.list{i}.type);
        if strcmp(O.list{i}.type,'bool') || strcmp(O.list{i}.type,'string')
          fprintf('  value..: %s\n',mat2str(O.list{i}.value));
        elseif strcmp(O.list{i}.type,'integer')
          fprintf('  value..: %d\n',O.list{i}.value);
        else
          fprintf('  value..: %e\n',O.list{i}.value);
        end
        if strcmp(O.list{i}.type,'integer')
          fprintf('  lower..: %d\n',O.list{i}.lower);
          fprintf('  upper..: %d\n',O.list{i}.upper);          
        elseif strcmp(O.list{i}.type,'double')
          fprintf('  lower..: %e\n',O.list{i}.lower);
          fprintf('  upper..: %e\n',O.list{i}.upper);          
        end
      end
      
    end
    
  end
  
end