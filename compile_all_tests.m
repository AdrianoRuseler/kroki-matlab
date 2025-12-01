%% Creates SVG files
clc
clear all

[status, cmdout] = system('curl -s http://localhost:8000/health');
% Assuming cmdout contains the JSON string
jsonStruct = jsondecode(cmdout);

% 1. Extract the structure containing all the versions
versionStruct = jsonStruct.version;

% 2. Get a list of all field names (the tool names)
toolNames = fieldnames(versionStruct);

% List all files inside each targetDir and display their names
for i = 1:length(toolNames)
    targetDir = fullfile('tests/', toolNames{i});
    % List all files inside each targetDir and display their names
    files = dir(targetDir);
    % Exclude the current directory and parent directory from the list
    files = files(~ismember({files.name}, {'.', '..'}));
    files = files(~endsWith({files.name}, {'.md','.svg'})); % Exclude .md and .svg files from the list

    % Display the total number of files found in the directory
    fprintf('Total files in %s: %d\n', targetDir, length(files));

    % Create curl command for each file
    for f=1:length(files)
        % Execute the curl command for the current file
        curl_command = sprintf('curl -s -X POST -H "Content-Type: text/plain" --data-binary "@%s" http://localhost:8000/%s/svg', fullfile(targetDir, files(f).name), toolNames{i});
        [status, cmdout] = system(curl_command);
        if status == 0
            % disp(['Curl command for ', toolNames{i}, ' executed successfully.']);
            % Save cmdout as an SVG file
            [~,name] = fileparts(files(f).name);
            svgFilePath = fullfile(targetDir, [name, '.svg']);
            fidSvg = fopen(svgFilePath, 'w');
            if fidSvg ~= -1
                fwrite(fidSvg, cmdout);
                fclose(fidSvg);
                disp(['SVG file saved: ', svgFilePath]);
            else
                disp(['Error saving SVG file for ', files(f).name]);
            end
        else
            disp(['Error executing curl command for ', toolNames{i}, '. Status: ', num2str(status)]);
        end
    end
end

%% Creates SVG files for specific tool
clc
clear all

[status, cmdout] = system('curl -s http://localhost:8000/health');
jsonStruct = jsondecode(cmdout);
versionStruct = jsonStruct.version;
toolNames = fieldnames(versionStruct);

buildfor='bytefield'; % Change this
targetDir = fullfile('tests/', buildfor);
% List all files inside each targetDir and display their names
files = dir(targetDir);
% Exclude the current directory and parent directory from the list
files = files(~ismember({files.name}, {'.', '..'}));
files = files(~endsWith({files.name}, {'.md','.svg'})); % Exclude .md and .svg files from the list

% Create curl command for each file
for f=1:length(files)
    % Execute the curl command for the current file
    curl_command = sprintf('curl -s -X POST -H "Content-Type: text/plain" --data-binary "@%s" http://localhost:8000/%s/svg', fullfile(targetDir, files(f).name), buildfor);
    [status, cmdout] = system(curl_command);
    if status == 0
        % disp(['Curl command for ', toolNames{i}, ' executed successfully.']);
        % Save cmdout as an SVG file
        [~,name] = fileparts(files(f).name);
        svgFilePath = fullfile(targetDir, [name, '.svg']);
        fidSvg = fopen(svgFilePath, 'w');
        if fidSvg ~= -1
            fwrite(fidSvg, cmdout);
            fclose(fidSvg);
            disp(['SVG file saved: ', svgFilePath]);
        else
            disp(['Error saving SVG file for ', files(f).name]);
        end
    else
        disp(['Error executing curl command for ', buildfor, '. Status: ', num2str(status)]);
    end
end


%% Create info quiz
clc
clear all

infos.xmlpath=[pwd '\xmlfiles']; % xmlfiles
infos.fname='Kroki-tests';

[status, cmdout] = system('curl -s http://localhost:8000/health');
% Assuming cmdout contains the JSON string
jsonStruct = jsondecode(cmdout);

% 1. Extract the structure containing all the versions
versionStruct = jsonStruct.version;

% 2. Get a list of all field names (the tool names)
toolNames = fieldnames(versionStruct);

% List all files inside each targetDir and display their names
q=1;
for i = 1:length(toolNames)
    targetDir = fullfile('tests/', toolNames{i});
    % List all files inside each targetDir and display their names
    files = dir(targetDir);
    % Exclude the current directory and parent directory from the list
    files = files(~ismember({files.name}, {'.', '..'}));
    files = files(~endsWith({files.name}, {'.md','.svg'})); % Exclude .md and .svg files from the list

    % Display the total number of files found in the directory
    fprintf('Total files in %s: %d\n', targetDir, length(files));

    % Create curl command for each file
    for f=1:length(files)
        % Execute the curl command for the current file
        curl_command = sprintf('curl -s -X POST -H "Content-Type: text/plain" --data-binary "@%s" http://localhost:8000/%s/svg', fullfile(targetDir, files(f).name), toolNames{i});
        [status, cmdout] = system(curl_command);
        if status == 0
            encoded_string = matlab.net.base64encode(cmdout);
            imgstr=['<img src="data:image/svg+xml;base64,' encoded_string '">'];
            infos.q(q).text=['<code>' curl_command '</code><p>' imgstr '</p>'];
            infos.q(q).name=[toolNames{i} ': ' files(f).name];
            q=q+1;
        else
            disp(['Error executing curl command for ', toolNames{i}, '. Status: ', num2str(status)]);
        end
    end
end


info2ioxml(infos)


%% SVG test

clc
clear all

% Get all SVG files from folder and subfolders
files = dir(fullfile('tests', '**', '*.svg'));
svgPaths = fullfile({files.folder}, {files.name});
% svgPaths{1}

for f=1:length(svgPaths)
    disp(svgPaths{f})
    isValid = verifySVG(svgPaths{f});
end

    
%% SVG inkscape convert

clc
clear all

% Get all SVG files from folder and subfolders
files = dir(fullfile('tests', '**', '*.svg'));
svgPaths = fullfile({files.folder}, {files.name});
% svgPaths{1}

for f=1:length(svgPaths)
    disp(svgPaths{f})
    [path,name] = fileparts(svgPaths{f});
    outfile = [path '\' name '_plain.svg'];
    [status, cmdout] = system(['inkscape ' svgPaths{f} ' --export-plain-svg --export-filename=' outfile]);
    % isValid = verifySVG(svgPaths{f});
end


%% Scour - An SVG Optimizer / Cleaner  for wavedrom
% https://github.com/scour-project/scour
% https://github.com/scour-project/scour/wiki/Documentation
% [status, cmdout] = system('pip install scour');

% scour -i input.svg -o output.svg
% [status, cmdout] = system('C:\Users\ruseler\AppData\Local\Programs\Python\Python313\python.exe -m pip install --upgrade pip');

% scour -i input.svg -o output.svg
% [status, cmdout] = system('scour');
% --enable-id-stripping → remove unused IDs
% --enable-comment-stripping → remove comments
% --shorten-ids → shorten IDs for compactness
% --indent=none → minify output (no pretty-printing)

clc
clear all

% Get all SVG files from folder and subfolders
files = dir(fullfile('tests', '**', '*.svg'));
svgPaths = fullfile({files.folder}, {files.name});
% svgPaths{1}

% svgPaths{1}='C:\Users\ruseler\Documents\GitHub\kroki-matlab\tests\mermaid\SankeyDiagram.svg'

% opts=' --enable-id-stripping --enable-comment-stripping --shorten-ids --indent=none ';
% The maximal version of Optimizing is:
% opts='--enable-comment-stripping --strip-xml-space --remove-metadata --renderer-workaround --remove-descriptions --enable-id-stripping --shorten-ids --set-precision=5 --set-c-precision=5 --create-groups --remove-descriptive-elements --remove-titles --enable-viewboxing';

for f=1:length(svgPaths)
    disp(svgPaths{f})
    [path,name] = fileparts(svgPaths{f});
    outfile = [path '\' name '_scour.svg'];
    [status, cmdout] = system(['scour -i ' svgPaths{f} ' -o ' outfile]);
    % [status, cmdout] = system(['scour -i ' svgPaths{f} ' -o ' outfile ' ' opts]);
    % isValid = verifySVG(svgPaths{f});
end

%% Creates info quiz from svg files;
clc
clear all

infos.xmlpath=[pwd '\xmlfiles']; % xmlfiles
infos.fname='Kroki-tests';

% Get all SVG files from folder and subfolders
files = dir(fullfile('tests', '**', '*.svg'));
svgPaths = fullfile({files.folder}, {files.name});
% svgPaths{1}

for f=1:length(svgPaths)
    [path,name] = fileparts(svgPaths{f});
    parts = split(path, filesep);   % split by "\" on Windows or "/" on Linux/Mac
    lastStr = parts{end};              % "example.svg"

    svgString = fileread(svgPaths{f});
    encoded_string = matlab.net.base64encode(svgString);
    imgstr=['<img src="data:image/svg+xml;base64,' encoded_string '">'];
    infos.q(f).text=['<code>' svgPaths{f} '</code><p>' imgstr '</p>'];
    infos.q(f).name=[lastStr ': ' name];
end

info2ioxml(infos)
