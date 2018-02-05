classdef LogisticRegression < BaseEstimator
    
    properties
        reg = 1E-2; % regularization
        coef_; % coefficients
        sample_weights; % weights for individual samples
    end
    
    methods
        % constructor
        function obj = LogisticRegression(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        function fit(obj,X,Y,~)
            % initialize as regression solution
            lambda = obj.reg;
            w = (X'*X+lambda*eye(size(X,2)))\X'*Y;
            
            if isempty(obj.sample_weights)
                obj.sample_weights = ones(size(X,1),1);
            end
            sw = obj.sample_weights;
            
            % logistic regression
            options = optimset('GradObj', 'on', 'MaxIter', 400,...
                'Display', 'off');
            [w, J, exit_flag] = ...
                fminunc(@(t)(log_cost_function_reg(t,X,Y,lambda,sw)),...
                w, options); %#ok<ASGLU>
            
            obj.coef_ = w(:);
        end
        
        function proba = predict_proba(obj,X,~)
            proba = 1 ./ (1 + exp(-X*obj.coef_)); % sigmoid
        end
    end
end
