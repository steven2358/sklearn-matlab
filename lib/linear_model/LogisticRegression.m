classdef LogisticRegression < handle
    
    properties
        reg = 1E-2; % regularization
        coef_; % coefficients
    end
    
    methods
        % constructor
        function obj = LogisticRegression(parameters)
            if (nargin > 0) % copy valid parameters
                for fn = fieldnames(parameters)',
                    if ismember(fn,fieldnames(obj)),
                        obj.(fn{1}) = parameters.(fn{1});
                    end
                end
            end
        end
        
        function fit(obj,X,Y)
            % initialize as regression solution
            lambda = obj.reg;
            w = (X'*X+lambda*eye(size(X,2)))\X'*Y;
            
            % logistic regression
            options = optimset('GradObj', 'on', 'MaxIter', 400,...
                'Display', 'off');
            [w, J, exit_flag] = ...
                fminunc(@(t)(log_cost_function_reg(t, X, Y, lambda)),...
                w, options); %#ok<ASGLU>
            
            obj.coef_ = w(:);
        end
        
        function proba = predict_proba(obj,X)
            proba = 1 ./ (1 + exp(-X*obj.coef_)); % sigmoid
        end
    end    
end
