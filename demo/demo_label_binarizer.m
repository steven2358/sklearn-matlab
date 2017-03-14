% Label Binarizer demo.

close all
clear

y_train = [1, 2, 6, 4, 2];
fprintf('Train labels:\n')
disp(y_train)

lb = LabelBinarizer();
lb.fit(y_train);
fprintf('Binarized classes:\n')
disp(lb.classes_)

y_test = [1, 1, 2, 4, 6, 6, 1, 2, 4];
fprintf('test labels:\n')
disp(y_test)

y_new = lb.transform(y_test);
fprintf('Transformed test labels:\n')
disp(y_new)

y_test_orig = lb.inverse_transform(y_new);
fprintf('Recovered test labels:\n')
disp(y_test_orig)
