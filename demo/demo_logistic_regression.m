% Logistic regression demo on dummy 2D data

close all
clear

[X_train, X_test, y_train, y_test] = sklearn_data_2clusters();

f1 = figure; hold all
plot(X_train(y_train==0,1),X_train(y_train==0,2),'o')
plot(X_train(y_train==1,1),X_train(y_train==1,2),'o')
title('Training data')

clf = LogisticRegression;

clf.fit(X_train,y_train);

proba = clf.predict_proba(X_test);

[perfx,perfy,T,AUC] = perfcurve(y_test,proba,true);

fprintf('AUC = %.4f\n',AUC)

f2 = figure; plot(perfx,perfy)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC for Classification by Logistic Regression')
