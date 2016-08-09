classdef Pipeline < handle
    % Pipeline of transforms with a final estimator.
    %
    % Sequentially apply a list of transforms and a final estimator.
    % Intermediate steps of the pipeline must be ‘transforms’, that is,
    % they must implement fit and transform methods. The final estimator
    % only needs to implement fit.
    %
    % The purpose of the pipeline is to assemble several steps that can be
    % cross-validated together while setting different parameters. For
    % this, it enables setting parameters of the various steps using their
    % names and the parameter name separated by a '__'.
    
    properties
        named_steps;
        num_steps;
    end
    
    methods        
        % constructor
        function obj = Pipeline(estimators)
            if (nargin > 0) % copy valid parameters
                fn = fieldnames(estimators);
                obj.num_steps = length(fn);
                obj.named_steps = cell(obj.num_steps,1);
                for i=1:obj.num_steps,
                    obj.named_steps{i}.name = fn{i};
                    obj.named_steps{i}.estimator = estimators.(fn{i});
                end
            end
        end
        
        % Fit all the transforms one after the other and transform the
        % data, then fit the transformed data using the final estimator.
        function fit(obj,X,Y)
            X_fit = X;
            for i=1:obj.num_steps-1
                X_fit = obj.named_steps{i}.estimator.fit_transform(X_fit);
            end
            obj.named_steps{end}.estimator.fit(X_fit,Y);
        end
        
        % Applies transforms to the data, and the predict_proba method of
        % the final estimator. Valid only if the final estimator implements
        % predict_proba.
        function proba = predict_proba(obj,X)
            X_fit = X;
            for i=1:obj.num_steps-1
                X_fit = obj.named_steps{i}.estimator.fit_transform(X_fit);
            end
            proba = obj.named_steps{end}.estimator.predict_proba(X_fit);
        end        
    end    
end
