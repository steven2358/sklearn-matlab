% Script to run all demos consecutively.

close all
clear

% get list of test functions
fdir = fileparts(which('run_all_demos.m'));
files = dir(fullfile(fdir,'demo_*.m'));
[~,allfiles] = cellfun(@fileparts, {files.name}, 'UniformOutput',0);

t1 = tic;
fprintf('\n')
for i=1:length(allfiles)
    close all
    clear eval
    save(fullfile(tempdir,'temp.mat'),'i','allfiles','t1'); % memory map
    
    % run script
    fname_demo = allfiles{i};
    fprintf('\nRunning %s\n',fname_demo);
    eval(fname_demo);

    load(fullfile(tempdir,'temp.mat'));
end
fprintf('\n')
delete(fullfile(tempdir,'temp.mat'));
toc(t1)

close all
