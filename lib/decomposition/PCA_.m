classdef PCA_ < handle
    
    properties
        n_components = 2;
        components;
    end
    
    methods
        % constructor
        function obj = PCA_(parameters)
            if (nargin > 0) % copy valid parameters
                for fn = fieldnames(parameters)',
                    if ismember(fn,fieldnames(obj)),
                        obj.(fn{1}) = parameters.(fn{1});
                    end
                end
            end
        end
        
        function fit(obj,X)
            coeff = pca(X);
            obj.components = coeff(:,1:obj.n_components);
        end
        
        function X_new = transform(obj,X)
            X_new = X*obj.components;
        end
        
        function X_new = fit_transform(obj,X)
            obj.fit(X);
            X_new = obj.transform(X);
        end
    end
end
