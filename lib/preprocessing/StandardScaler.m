classdef StandardScaler < BaseEstimator
    % Standardize features by removing the mean and scaling to unit
    % variance.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        with_mean = true;
        with_std = true;
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        scale_; % Per feature relative scaling of the data.
        mean_; % The mean value for each feature in the training set.
        var_; % The variance for each feature in the training set.
    end
    
    methods
        % constructor
        function obj = StandardScaler(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Compute the mean and std to be used for later scaling.
        function fit(obj,X,~)
            if obj.with_mean
                obj.mean_ = mean(X,1);
            end
            if obj.with_std
                obj.var_ = var(X);
                obj.scale_ = 1./sqrt(obj.var_);
                
                % handle scale for zero variance
                obj.scale_(obj.var_==0) = 1;
            end
        end
        
        % Perform standardization by centering and scaling
        function X_new = transform(obj,X)
            X_new = X;
            if obj.with_mean
                X_new = bsxfun(@minus,X_new,obj.mean_);
            end
            if obj.with_std
                X_new = bsxfun(@times,X_new,obj.scale_);
            end
        end
        
        % Fit to data, then transform it.
        function X_new = fit_transform(obj,X,~)
            obj.fit(X);
            X_new = obj.transform(X);
        end
        
        % Scale back the data to the original representation
        function X_orig = inverse_transform(obj,X)
            X_orig = X;
            if obj.with_mean
                X_orig = bsxfun(@plus,X_orig,obj.mean_);
            end
            if obj.with_std
                X_orig = bsxfun(@rdivide,X_orig,obj.scale_);
            end
        end
    end
end
