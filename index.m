clc
clear all

[status, cmdout] = system('curl -s http://localhost:8000/health');
% Assuming cmdout contains the JSON string
jsonStruct = jsondecode(cmdout);

% 1. Extract the structure containing all the versions
versionStruct = jsonStruct.version;

% 2. Get a list of all field names (the tool names)
toolNames = fieldnames(versionStruct);
% disp(toolNames)
disp(['Service Status: ', jsonStruct.status]);

disp('--- All Tool Versions ---');
for i = 1:length(toolNames)
    tool = toolNames{i};

    % Retrieve the value using the tool name variable
    toolVersion = versionStruct.(tool);

    % Handle the nested 'kroki' field which is another structure
    if isstruct(toolVersion)
        toolVersion = toolVersion.number; % Extract the 'number' field
    end

    disp([tool, ': ', toolVersion]);

    targetDir = fullfile('tests/', tool);
    if ~isfolder(targetDir)
        mkdir(targetDir);
    end
end

% Create README.md file in each targetDir
for i = 1:length(toolNames)
    tool = toolNames{i};
    targetDir = fullfile('tests/', tool);
    readmePath = fullfile(targetDir, 'README.md');
    disp(readmePath)
    fid = fopen(readmePath, 'w');
    if fid ~= -1
        toolVersion = versionStruct.(tool);
        % Handle the nested 'kroki' field which is another structure
        if isstruct(toolVersion)
            fprintf(fid, '# %s\n\nVersion: %s\n', tool, toolVersion.number);
        else
            fprintf(fid, '# %s\n\nVersion: %s\n', tool, toolVersion);
        end

        
        fclose(fid);
    else
        disp(['Error creating README.md for ', tool]);
    end
end

% Prepare to execute the curl commands for each tool
for i = 1:length(toolNames)
    tool = toolNames{i};
    curl_command = sprintf('curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/%s/input.dot" http://localhost:8000/%s/svg', tool,tool);

    % Run the command for each tool
    [status, cmdout] = system(curl_command);

    if status == 0
        disp(['Curl command for ', tool, ' executed successfully.']);
    else
        disp(['Error executing curl command for ', tool, '. Status: ', num2str(status)]);
    end
end


%% POST

% 1. Construct your full curl command as a string
% curl_command = 'curl -s -X POST -H "Content-Type: text/plain" http://localhost:8000/graphviz/svg --data-raw "digraph G {Hello->World}"';

% curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg';

curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg';
% curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/tikz/directional-angles.tex" http://localhost:8000/tikz/svg';

curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/mermaid/flowchart.mmd" http://localhost:8000/mermaid/svg';


curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/blockdiag/simple.diag" http://localhost:8000/blockdiag/svg';



curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/bpmn/pizza-collaboration.bpmn" http://localhost:8000/bpmn/svg';



% 2. Run the command
[status, cmdout] = system(curl_command);

% status is the exit code (0 usually means success)
% cmdout is the text output from the curl command
if status == 0
    disp('Curl command executed successfully.');
    disp(cmdout);
else
    disp(['Error executing curl command. Status: ', num2str(status)]);
    disp(cmdout);
end

% 1. Encoding a string
encoded_string = matlab.net.base64encode(cmdout);
% disp(encoded_string);

% imgstr=['<img width="119px" height="155px" src="data:image/svg+xml;base64,' encoded_string '">'];
imgstr=['<img src="data:image/svg+xml;base64,' encoded_string '">'];
% 2. Copy the variable's content to the clipboard
clipboard('copy', imgstr);

%% CLI

% HTML Image
[status, cmdout] = system('kroki version');
[status, cmdout] = system('kroki convert -t tikz tests/tikz/directional-angles.tex');
[status, cmdout] = system('kroki convert -t mermaid tests/mermaid/flowchart.mmd');

[status, cmdout] = system('kroki encode tests/directional-angles.svg');

[status, cmdout] = system('kroki encode -h');

% 'Convert text diagram to image
%
% Usage:
% kroki convert file [flags]
%
% Flags:
% -c, --config string     alternate config file [env KROKI_CONFIG]
% -f, --format string     output format [base64 jpeg pdf png svg] (default: infer from output file extension otherwise svg)
% -h, --help              help for convert
% -o, --out-file string   output file (default: based on path of input file); use - to output to STDOUT
% -t, --type string       diagram type [actdiag blockdiag bpmn bytefield c4plantuml d2 diagramsnet ditaa erd excalidraw graphviz mermaid nomnoml nwdiag packetdiag pikchr plantuml rackdiag seqdiag structurizr svgbob umlet vega vegalite wavedrom] (default: infer from file extension)
% '

