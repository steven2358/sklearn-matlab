% Installation file. Adds local folders to path.

fprintf('Adding sklearn-matlab folders to Matlab path... ')

% add all subfolders of lib/
addpath(genpath(fullfile(pwd,'lib')));

% add /demo folder
addpath(fullfile(pwd,'demo'));

fprintf('done.\n')
disp('Type "savepath" if you wish to store the changes.')
% savepath;
