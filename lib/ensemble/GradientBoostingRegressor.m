classdef GradientBoostingRegressor < BaseEstimator & RegressorMixin
    % Gradient Boosting for regression.
    %
    % GB builds an additive model in a forward stage-wise fashion; it
    % allows for the optimization of arbitrary differentiable loss
    % functions. In each stage a regression tree is fit on the negative
    % gradient of the given loss function.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        
        % Loss function to be optimized. 'ls' refers to least squares
        % regression.
        loss = 'ls';
        
        n_estimators = 100; % The number of boosting stages to perform.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        regressor; % Matlab ensemble object
    end
    
    methods
        % constructor
        function obj = GradientBoostingRegressor(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % fit the gradient boosting model
        function fit(obj,X,y)
            
            loss_ = 'LSBoost';
            switch obj.loss
                case 'ls'
                    loss_ = 'LSBoost';
                case 'bag'
                    loss_ = 'Bag';
            end
            
            % train
            regressor_ = fitensemble(X, y, loss_,...
                obj.n_estimators, 'Tree', 'Type', 'regression');
            
            % store
            obj.regressor = compact(regressor_);
        end
        
        % predict regression target for X
        function C = predict(obj,X)
            C = obj.regressor.predict(X);
        end
    end
end
