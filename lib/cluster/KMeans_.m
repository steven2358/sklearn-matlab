classdef KMeans_ < handle
    % The KMeans algorithm clusters data by trying to separate samples in n
    % groups of equal variance, minimizing a criterion known as the inertia
    % or within-cluster sum-of-squares. This algorithm requires the number
    % of clusters to be specified.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        n_clusters = 8; % The number of clusters and centroids.
        max_iter = 300; % Maximum number of iterations for a single run.
        n_init = 10; % Number of time the k-means algorithm will be run
        % with different centroid seeds. The final results will be the best
        % output of n_init consecutive runs in terms of inertia.
        n_jobs = 1;
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        cluster_centers_; % Coordinates of cluster centers
        labels_; % Labels of each point
    end
    
    methods
        % constructor
        function obj = KMeans_(parameters)
            if (nargin > 0) % copy valid parameters
                for fn = fieldnames(parameters)',
                    if ismember(fn,fieldnames(obj)),
                        obj.(fn{1}) = parameters.(fn{1});
                    end
                end
            end
        end
        
        function fit(obj,X, ~)
            stream = RandStream('mlfg6331_64');  % Random number stream
            opts = statset('UseParallel',true,...
                'UseSubstreams',true,...
                'Streams',stream);
            
            [idx, C] = kmeans(X, obj.n_clusters,...
                'Distance','cityblock',...
                'Replicates',obj.n_init,...
                'MaxIter',1000,...
                'Display','final',...
                'Options',opts);
            
            obj.cluster_centers_ = C;
            obj.labels_ = idx;
        end
        
        function labels = fit_predict(obj,X, ~)
            obj.fit(X);
            labels = obj.predict(X);
        end
        
        function X_new = fit_transform(obj,X,~)
            obj.fit(X);
            X_new = obj.transform(X);
        end
        
        % Predict the closest cluster each sample in X belongs to.
        function labels = predict(obj,X,~)
            X_new = obj.transform(X);
            [~,labels] = min(X_new,[],2);
        end
        
        % Transform X to a cluster-distance space. In the new space, each
        % dimension is the distance to the cluster centers.
        function X_new = transform(obj,X,~)
            X_new = dist2(X,obj.cluster_centers_);
        end
    end
end
