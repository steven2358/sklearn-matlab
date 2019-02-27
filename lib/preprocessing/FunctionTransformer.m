classdef FunctionTransformer < BaseEstimator & TransformerMixin
    % Constructs a transformer from an arbitrary callable.
    %
    % A FunctionTransformer forwards its X (and optionally y) arguments to
    % a user-defined function or function object and returns the result of
    % this function. This is useful for stateless transformations such as
    % taking the log of frequencies, doing custom scaling, etc.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        func = @(x) x;
    end
    
    methods
        % constructor
        function obj = FunctionTransformer(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        function fit(obj,X,~) %#ok<INUSD>
        end
        
        function X_new = transform(obj,X)
            X_new = obj.func(X);
        end
    end
end
