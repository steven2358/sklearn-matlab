% PCA demo on dummy 2D data

close all
clear

[X_train, X_test, y_train, y_test] = sklearn_data_2clusters();

clf = PCA_(struct('n_components',1));
clf.fit(X_train+10);
v = clf.components;

f1 = figure; hold all
plot(X_train(:,1),X_train(:,2),'o')
plot(5*[-v(1) v(1)],5*[-v(2) v(2)],'r')
legend('Data','First principal component')
