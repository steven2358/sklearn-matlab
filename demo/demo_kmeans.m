% KMeans demo on dummy 2D data

close all
clear

[X_train, X_test, y_train, y_test] = sklearn_data_3clusters();

clf = KMeans_(struct('n_clusters',3));
clf.fit(X_train);

% test clustering on test data
y_est = clf.predict(X_test);

f1 = figure; hold all
plot(X_test(y_est==1,1),X_test(y_est==1,2),'o')
plot(X_test(y_est==2,1),X_test(y_est==2,2),'o')
plot(X_test(y_est==3,1),X_test(y_est==3,2),'o')
