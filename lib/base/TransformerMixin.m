classdef TransformerMixin < handle
    % Mixin class for all transformers in scikit-learn.
    
    methods
        % Fit to data, then transform it.
        function X_new = fit_transform(obj,X,y)
            if nargin>2
                % fit method of arity 1 (unsupervised transformation)
                obj.fit(X);
            else
                obj.fit(X,y);
            end
            X_new = obj.transform(X);
        end
    end
end
