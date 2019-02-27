classdef Nystroem < BaseEstimator & TransformerMixin
    % Nystroem method: Approximate a kernel map using a subset of the
    % training data.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        kernel = 'rbf'; % Kernel mapping. String or callable.
        gamma; % Gamma parameter for the RBF and similar kernels.
        coef0; % Zero coefficient for polynomial and sigmoid kernels.
        degree; % Degree of the polynomial kernel.
        kernel_params; % Parameters for callable kernel function. Optional.
        n_components = 100; % Number of components to keep.
        random_state; % Seed used by the random number generator. Integer.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        components_; % Subset of training points to construct feature map.
        component_indices_; % Indices of components_ in the training set.
        normalization_; % Normalization matrix needed for embedding. Square
        % root of the kernel matrix on components_.
    end
    
    methods
        % constructor
        function obj = Nystroem(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit estimator to data.
        function fit(obj,X,~)
            if ~isempty(obj.random_state)
                rng('default')
                rng(obj.random_state);
            end
            n_samples = size(X,1);
            
            % get basis vectors
            if obj.n_components > n_samples
                n_components_ = n_samples;
            else
                n_components_ = obj.n_components;
            end
            
            inds = randperm(n_samples);
            basis_inds = inds(1:n_components_);
            basis = X(basis_inds,:);
            
            basis_kernel = pairwise_kernels(basis, basis, obj.kernel,...
                obj.get_kernel_params());
            
            % sqrt of kernel matrix on basis vectors
            [U,S,V] = svd(basis_kernel);
            S = diag(max(diag(S), 1e-12));
            
            obj.normalization_ = transpose(U/sqrt(S))*V;
            obj.components_ = basis;
            obj.component_indices_ = inds;
        end
        
        % Apply feature map to X.
        function X_new = transform(obj,X)
            
            embedded = pairwise_kernels(X, obj.components_,...
                obj.kernel,obj.get_kernel_params());
            X_new = embedded*transpose(obj.normalization_);
        end
        
        function params = get_kernel_params(obj)
            if isa(obj.kernel,'function_handle')
                params = obj.kernel_params;
            else
                params = struct(...
                    'gamma',obj.gamma,...
                    'degree',obj.degree,...
                    'coef0',obj.coef0);
            end
        end
    end
end
