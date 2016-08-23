classdef PCA_ < handle
    % Principal component analysis (PCA).
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        n_components = 2; % Number of components to keep.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        components; % Principal axes in feature space.
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
        
        % Fit the model with X.
        function fit(obj,X,~)
            obj.components = pca(X,'NumComponents',obj.n_components);
        end
        
        % Apply the dimensionality reduction on X.
        function X_new = transform(obj,X)
            X_new = X*obj.components;
        end
        
        % Fit the model with X and apply the dimensionality reduction on X.
        function X_new = fit_transform(obj,X,~)
            obj.fit(X);
            X_new = obj.transform(X);
        end
    end
end
