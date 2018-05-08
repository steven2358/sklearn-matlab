classdef SVC < BaseEstimator & ClassifierMixin
    % Support Vector Classification.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        C = 1; % Penalty parameter C of the error term.
        kernel = 'rbf'; % Kernel mapping.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        model;
    end
    
    methods
        % constructor
        function obj = SVC(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit the model
        function fit(obj,X,y)
            obj.model = fitcsvm(X,y,...
                'KernelFunction',upper(obj.kernel),...
                'Cost',[0 obj.C; obj.C 0]);
        end
        
        % Predict using the model
        function C = predict(obj,X)
            [C,score] = predict(obj.model,X); %#ok<ASGLU>
        end
    end
end
