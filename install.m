% Installation file. Adds local folders to path.

fprintf('Adding sklearn-matlab folders to Matlab path... ')

% add lib/ with subfolders
addpath(genpath(fullfile(pwd,'lib')));

% add data/ folder
addpath(fullfile(pwd,'demo/data/'));

fprintf('done.\n')
disp('Type "savepath" if you wish to store the changes.')
% savepath;
