% K-nearest neighbors classifier demo.

close all
clear

%% PARAMETERS

test_size = 0.3;
n_neighbors = 5;

%% PROGRAM

load fisheriris
X = meas;
y = species;

[X_train, X_test, y_train, y_test] = train_test_split(X,y,test_size);

clf = KNeighborsClassifier(struct('n_neighbors',n_neighbors));

clf.fit(X,y);

y_pred = clf.predict(X_test);

%% OUTPUT

score = accuracy_score(y_test, y_pred);

fprintf('Accuracy: %.4f%%\n',score);
