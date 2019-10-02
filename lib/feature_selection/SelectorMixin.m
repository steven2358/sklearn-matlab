classdef SelectorMixin < TransformerMixin
    % Mixin class for all feature selection in scikit-learn.
    % Implements `transform` and `inverse_transform`, given a filter mask

    methods
        function mask = get_support(obj, return_indices)
            % Arguments
            %   return_indices (logical): if True, the return value will be
            %   an array of integers, rather than a boolean mask. default:
            %   false
            if nargin < 2
                return_indices = false;
            end
            mask = obj.get_support_mask();
            if return_indices
                mask = find(mask);
            end
        end
        
        % Reduce X to the selected features.
        function X_reduced = transform(obj, X)
            mask = obj.get_support();
            if ~any(mask)
                warning(['No features were selected: either the data is'...
                         ' too noisy or the selection test too strict.']);
                X_reduced = zeros(size(X, 1), 0);
            end
            assert(numel(mask) == size(X, 1),...
                   'X has a different shape than during fitting');

            X_reduced = X(:,mask);
        end
        
        % Reduce the transformation operation
        function X = inverse_transform(obj, X_reduced)
            error('Not yet implemented');
        end
    end
    
    methods (Abstract, Access = 'protected')
        get_support_mask(obj);
    end
end
