% Installation file. Adds local folders to path.

fprintf('Adding sklearn-matlab folders to Matlab path... ')

% add lib/ and demo/ with subfolders
addpath(genpath(fullfile(pwd,'lib')));
% addpath(genpath(fullfile(pwd,'demo')));

fprintf('done.\n')
disp('Type "savepath" if you wish to store the changes.')
% savepath;
