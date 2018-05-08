classdef KNeighborsClassifier < BaseEstimator & RegressorMixin
    % Classifier implementing the k-nearest neighbors vote.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        n_neighbors = 5; % Number of neighbors to use.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        model;
    end
    
    methods
        % constructor
        function obj = KNeighborsClassifier(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit the model.
        function fit(obj,X,y,~)
            obj.model = fitcknn(X,y,'NumNeighbors',obj.n_neighbors);
        end
        
        % Predict using the model.
        function C = predict(obj,X)
            C = predict(obj.model,X);
        end
    end
end
