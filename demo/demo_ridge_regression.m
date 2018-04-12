% Ridge regression demo on dummy data.

close all
clear
rng('default'); rng(1); % Reproducibility

[X_train, X_test, y_train, y_test] = sklearn_data_noisyplane();

f1 = figure;
plot3(X_train(:,1),X_train(:,2),y_train,'.')
view([45 45 0])
axis equal
grid on
title('Training data (3D)')

clf = Ridge;

clf.fit(X_train,y_train);

score = clf.score(X_test,y_test);

fprintf('Regression score is %.2f\n',score);

y_pred = clf.predict(X_test);

f2 = figure; hold all
plot3(X_test(:,1),X_test(:,2),y_test,'.')
plot3(X_test(:,1),X_test(:,2),y_pred,'.')
view([80 50 30])
axis equal
grid on
legend('true','predicted')
