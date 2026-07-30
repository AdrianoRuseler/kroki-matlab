function addToolCategoryJson(toolsID)
% addToolCategoryJson creates or overwrites _category_.json in each tool's TargetDir
% Input: toolsID can be a single string or a cell array of strings

% Normalize input to a cell array
if ischar(toolsID) || isstring(toolsID)
    toolsID = {char(toolsID)};
elseif ~iscell(toolsID)
    error('toolsID must be a string or a cell array of tool IDs');
end

% Loop through each tool ID
for i = 1:numel(toolsID)
    % Get tool info (includes TargetDir)
    info = getToolInfo(toolsID{i});

    % Ensure folder exists (create if missing)
    if ~exist(info.TargetDir, 'dir')
        mkdir(info.TargetDir);
        fprintf('Created folder: %s\n', info.TargetDir);
    end

    % Path for _category_.json
    categoryPath = fullfile(info.TargetDir, '_category_.json');

    % Build JSON content
    jsonContent = sprintf([ ...
        '{\n' ...
        '  "label": "%s",\n' ...
        '  "position": %s,\n' ...
        '  "link": {\n' ...
        '    "type": "generated-index",\n' ...
        '    "description": "%s"\n' ...
        '  }\n' ...
        '}'], info.Name, info.Pos, info.Description);

    % Write file
    fid = fopen(categoryPath, 'w');
    if fid ~= -1
        fprintf(fid, '%s', jsonContent);
        fclose(fid);
        fprintf('Wrote _category_.json in: %s\n', info.TargetDir);
    else
        warning('Could not write _category_.json in %s', info.TargetDir);
    end
end
end
