% Support Vector Machine classifier demo.

close all
clear

%% PARAMETERS

test_size = 0.3;

%% PROGRAM

load fisheriris
ind = ~strcmp(species,'setosa');
X = meas(ind,:);
y = species(ind);

[X_train, X_test, y_train, y_test] = train_test_split(X,y,test_size);

clf = SVC(struct('kernel','RBF','gamma',1));

clf.fit(X_train,y_train);

y_pred = clf.predict(X_test);

%% OUTPUT

score = accuracy_score(y_test, y_pred);

fprintf('Accuracy: %.4f%%\n',score);

sv = clf.model.SupportVectors;

figure; hold all
ind1 = strcmp(y_train,'versicolor');
ind2 = strcmp(y_train,'virginica');
plot(X_train(ind1,3),X_train(ind1,4),'.','MarkerSize',16)
plot(X_train(ind2,3),X_train(ind2,4),'.','MarkerSize',16)
plot(sv(:,3),sv(:,4),'ko','MarkerSize',10)
legend({'versicolor','setosa','Support Vector'},'Location','best')
