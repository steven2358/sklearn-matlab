classdef Ridge < handle
    %RIDGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        alpha = 1E-2; % regularization
        
        coef_
    end
    
    methods
        % constructor
        function obj = Ridge(parameters)
            if (nargin > 0) % copy valid parameters
                for fn = fieldnames(parameters)',
                    if ismember(fn,fieldnames(obj)),
                        obj.(fn{1}) = parameters.(fn{1});
                    end
                end
            end
        end
        
        function fit(obj,X,y)
            lambda = obj.alpha;
            w = (X'*X+lambda*eye(size(X,2)))\X'*y;
            
            obj.coef_ = w(:);
        end
        
        function y_pred = predict(obj,X)
            y_pred = X*obj.coef_;
        end
        
        function R2 = score(obj,X,y)
            y_pred = obj.predict(X);
            u = sum((y-y_pred).^2);
            v = sum((y-mean(y)).^2);
            R2 = 1-u/v; % coefficient of determination R^2
        end
    end
end
