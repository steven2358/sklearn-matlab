classdef SVC < BaseEstimator & ClassifierMixin
    % Support Vector Classification.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        C = 1; % Penalty parameter C of the error term.
        kernel = 'rbf'; % Kernel mapping. String or callable.
        gamma = 1; % Gamma parameter for the RBF. Scalar or 'auto'.
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
                'Cost',[0 obj.C; obj.C 0],...
                'KernelScale',1/sqrt(obj.gamma));
        end
        
        % Predict using the model
        function C = predict(obj,X)
            C = predict(obj.model,X);
        end
        
        function proba = pred_proba(obj,X)
            [~,score] = predict(obj.model,X);
            proba = score(:,2);
        end
    end
end
