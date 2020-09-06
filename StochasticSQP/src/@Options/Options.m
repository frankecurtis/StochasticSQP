% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis

% Options class
classdef Options < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % MEMBERS %
    %%%%%%%%%%%
    list = {}
            
  end
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function O = Options
      
      % DO NOTHING
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print
    function print(O,reporter)
      
      % Loop through list
      for i = 1:length(O.list)
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'Option %d:\n',i);
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  name...: %s\n',O.list{i}.name);
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  type...: %s\n',O.list{i}.type);
        if strcmp(O.list{i}.type,'bool') || strcmp(O.list{i}.type,'string')
          reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  value..: %s\n',mat2str(O.list{i}.value));
        elseif strcmp(O.list{i}.type,'integer')
          reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  value..: %d\n',O.list{i}.value);
        else
          reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  value..: %e\n',O.list{i}.value);
        end
        if strcmp(O.list{i}.type,'integer')
          reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  lower..: %d\n',O.list{i}.lower);
          reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  upper..: %d\n',O.list{i}.upper);          
        elseif strcmp(O.list{i}.type,'double')
          reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  lower..: %e\n',O.list{i}.lower);
          reporter.printf(Enumerations.R_SOLVER,Enumerations.R_BASIC,'  upper..: %e\n',O.list{i}.upper);          
        end
      end
      
    end % print
    
    %%%%%%%%%%%%%%%
    % ADD METHODS %
    %%%%%%%%%%%%%%%
    
    % Add bool option
    function addBoolOption(O,reporter,name,value)
      
      % Check if name already taken
      if O.nameTaken(name)
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                        'Options: Duplicate name of option (%s)! Refusing to add this one.\n',name);
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
      
      % Print message
      reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                      'Options: Bool option %s added with value %d.\n',option.name,mat2str(option.value));
      
    end % addBoolOption

    % Add bool option
    function addDoubleOption(O,reporter,name,value,lower,upper)
      
      % Check if name already taken
      if O.nameTaken(name)
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                        'Options: Duplicate name of option (%s)! Refusing to add this one.\n',name);
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

      % Print message
      reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                      'Options: Double option %s added with value %+e.\n',option.name,option.value);
      
    end % addDoubleOption
    
    % Add bool option
    function addIntegerOption(O,reporter,name,value,lower,upper)
      
      % Check if name already taken
      if O.nameTaken(name)
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                        'Options: Duplicate name of option (%s)! Refusing to add this one.\n',name);
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
      
      % Print message
      reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                      'Options: Integer option %s added with value %d.\n',option.name,option.value);

    end % addIntegerOption
    
    % Add bool option
    function addStringOption(O,reporter,name,value)
      
      % Check if name already taken
      if O.nameTaken(name)
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                        'Options: Duplicate name of option (%s)! Refusing to add this one.\n',name);
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

      % Print message
      reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                      'Options: String option %s added with value %s.\n',option.name,option.value);

    end % addStringOption
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Get option
    function v = getOption(O,reporter,name)
      
      % Initialize boolean
      name_found = false;
      
      % Loop through list
      for i = 1:length(O.list)
        if strcmp(O.list{i}.name,name)
          v = O.list{i}.value;
          name_found = true;
          break;
        end
      end
      
      % Check if name found
      if ~name_found
        reporter.printf(Enumerations.R_SOLVER,Enumerations.R_DETAILED,...
                        'Options: Attempted to fine option (%s), but name not found.\n',option.name,option.value);
      end
      
    end % getOption
    
    %%%%%%%%%%%%%%%%%
    % CHECK METHODS %
    %%%%%%%%%%%%%%%%%

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
      
    end % nameTaken
        
  end % methods (public access)
  
end % Options