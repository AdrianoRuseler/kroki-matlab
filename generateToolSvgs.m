function generateToolSvgs(toolsID)
% generateToolSvgs creates dump SVG files inside img/tools/ToolName.svg
% Input: toolsID can be a single string or a cell array of strings
% Example: generateToolSvgs({'mermaid','plantuml','actdiag'})

% Normalize input to a cell array
if ischar(toolsID) || isstring(toolsID)
    toolsID = {char(toolsID)};
elseif ~iscell(toolsID)
    error('toolsID must be a string or a cell array of tool IDs');
end

% Target directory
targetDir = fullfile('img','tools');

% Ensure folder exists
if ~exist(targetDir, 'dir')
    mkdir(targetDir);
    fprintf('Created folder: %s\n', targetDir);
end

% Loop through each tool ID
for i = 1:numel(toolsID)
    toolName = char(toolsID{i});
    svgPath = fullfile(targetDir, [toolName '.svg']);

    % Dump SVG content with viewBox layout
    svgContent = sprintf([ ...
        '<svg xmlns="http://www.w3.org/2000/svg" width="160" height="90" viewBox="0 0 160 90">\n' ...
        '  <rect width="100%%" height="100%%" fill="lightgray" stroke="black"/>\n' ...
        '  <text x="80" y="45" font-size="20" text-anchor="middle" dominant-baseline="central" fill="black">%s</text>\n' ...
        '</svg>\n'], toolName);

    % Write file
    fid = fopen(svgPath, 'w');
    if fid ~= -1
        fprintf(fid, '%s', svgContent);
        fclose(fid);
        fprintf('Wrote SVG dump for tool: %s → %s\n', toolName, svgPath);
    else
        warning('Could not write SVG file for %s', toolName);
    end
end
end
