classdef KernelRidge < BaseEstimator & RegressorMixin
    % Kernel ridge regression.
    %
    % Kernel ridge regression (KRR) combines ridge regression (linear least
    % squares with L2-norm regularization) with the kernel trick. It thus
    % learns a linear function in the space induced by the respective
    % kernel and the data. For non-linear kernels, this corresponds to a
    % non-linear function in the original space.
    %
    % The form of the model learned by KRR is identical to support vector
    % regression (SVR). However, different loss functions are used: KRR
    % uses squared error loss while support vector regression uses
    % epsilon-insensitive loss, both combined with L2 regularization. In
    % contrast to SVR, fitting a KRR model can be done in closed-form and
    % is typically faster for medium-sized datasets. On the other  hand,
    % the learned model is non-sparse and thus slower than SVR, which
    % learns a sparse model for epsilon > 0, at prediction-time.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        alpha = 1; % Regularization. Corresponds to C^-1.
        kernel = 'linear'; % Kernel mapping. String or callable.
        gamma = []; % Gamma parameter for the RBF and similar kernels.
        degree = 3; % Degree of the polynomial kernel.
        coef0 = 1; % Zero coefficient for polynomial and sigmoid kernels.
        kernel_params; % Parameters for callable kernel function. Optional.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        dual_coef_; % Representation of weight vector(s) in kernel space.
        X_fit_; % Stored training data. Shape: n_samples * n_features.
    end
    
    methods
        % constructor
        function obj = KernelRidge(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit the kernel ridge regression model
        function fit(obj,X,y)
            % TODO: replace by Cholesky

            I = eye(size(X,1));
            K = obj.get_kernel(X, X);
            
            obj.dual_coef_ = (K+I/obj.alpha)\y;
            obj.X_fit_ = X;
        end
        
        % Predict using the kernel ridge model
        function C = predict(obj,X)
            K = obj.get_kernel(X, obj.X_fit_);
            C = K*obj.dual_coef_;
        end
        
        function K = get_kernel(obj, X, Y)
            if isa(obj.kernel,'function_handle')
                params = obj.kernel_params;
            else
                params = struct(...
                    'gamma',obj.gamma,...
                    'degree',obj.degree,...
                    'coef0',obj.coef0);
            end
            K = pairwise_kernels(X, Y, obj.kernel, params);
        end
    end
end