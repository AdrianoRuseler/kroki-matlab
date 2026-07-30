function [toolsID, toolsName, cmdout] = getkrokitools(useLocal)
% getkrokitools queries Kroki health endpoint and returns tool IDs and names
% useLocal = true  -> http://localhost:8000/health
% useLocal = false -> https://kroki.mini.pc/health
% [toolsID, toolsName, cmdout] = getkrokitools(true);   % local Kroki
% [toolsID, toolsName, cmdout] = getkrokitools(false);  % remote Kroki

if nargin < 1 || isempty(useLocal)
    useLocal = true;
end
try
    if useLocal
        [status, cmdout] = system('curl -s http://localhost:8000/health');
    else
        [status, cmdout] = system('curl -k -s https://kroki.mini.pc/health');
    end

    % if status == 0
    %     fprintf('Health check succeeded: %s\n', strtrim(cmdout));
    % else
    %     fprintf('Health check failed with status %d\nOutput: %s\n', status, cmdout);
    % end

catch ME
    status = -1;
    cmdout = '';
    fprintf('Error running health check: %s\n', ME.message);
end

% If curl failed, return empty
if status ~= 0
    toolsID = {};
    toolsName = {};
    disp(cmdout)
    return
end

% Decode JSON response
jsonStruct = jsondecode(cmdout);

% Extract version info
versionStruct = jsonStruct.version;

% Tool IDs are field names
toolsID = fieldnames(versionStruct);
toolsName = cell(size(toolsID));

% Map IDs to formatted names
for i = 1:numel(toolsID)
    toolsName{i} = getToolName(toolsID{i});
end
end
