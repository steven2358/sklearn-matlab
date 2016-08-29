classdef ClassTemplate < handle
    % Summary of this class goes here
    %
    % Detailed explanation goes here
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
    end
    
    methods
        % constructor
        function obj = ClassTemplate(parameters)
            if (nargin > 0) % copy valid parameters
                for fn = fieldnames(parameters)',
                    if ismember(fn,fieldnames(obj)),
                        obj.(fn{1}) = parameters.(fn{1});
                    end
                end
            end
        end
        
    end
end
