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

    % Use getfield() to retrieve the value using the tool name variable
    toolVersion = getfield(versionStruct, tool);

    % Handle the nested 'kroki' field which is another structure
    if isstruct(toolVersion)
        toolVersion = toolVersion.number; % Extract the 'number' field
    end

    disp([tool, ': ', toolVersion]);
end


%% POST

% 1. Construct your full curl command as a string
% curl_command = 'curl -s -X POST -H "Content-Type: text/plain" http://localhost:8000/graphviz/svg --data-raw "digraph G {Hello->World}"';

% curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg';

curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg';
% curl_command = 'curl -s -X POST -H "Content-Type: text/plain" --data-binary "@tests/directional-angles.tex" http://localhost:8000/tikz/svg';

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



%% CLI

% HTML Image
[status, cmdout] = system('kroki version');
[status, cmdout] = system('kroki convert -t tikz tests/directional-angles.tex');

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

