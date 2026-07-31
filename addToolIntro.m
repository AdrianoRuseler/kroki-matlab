function addToolIntro(toolsID)
% addToolReadme creates or overwrites README.md in each tool's TargetDir
% Input: toolsID can be a single string or a cell array of strings

% Normalize input to a cell array
if ischar(toolsID) || isstring(toolsID)
    toolsID = {char(toolsID)};
elseif ~iscell(toolsID)
    error('toolsID must be a string or a cell array of tool IDs');
end

% Loop through each tool ID
for i = 1:numel(toolsID)
    % Get tool info (includes TargetDir + extended metadata)
    info = getToolInfo(toolsID{i});

    % Ensure folder exists (create if missing)
    if ~exist(info.TargetDir, 'dir')
        mkdir(info.TargetDir);
        fprintf('Created folder: %s\n', info.TargetDir);
    end

    % Path for intro.mdx
    readmePath = fullfile(info.TargetDir, 'intro.mdx');

    % Overwrite intro.mdx with fresh metadata
    fid = fopen(readmePath, 'w');
    if fid ~= -1
        % ---
        fprintf(fid, '---\n');
        % sidebar_label: Overview
        fprintf(fid, 'sidebar_label: Overview\n');
        % sidebar_position: 1
        fprintf(fid, 'sidebar_position: 1\n');
        % ---
        fprintf(fid, '---\n');

        fprintf(fid, '\n# %s\n\n',info.Name);

        fprintf(fid, '%s\n\n',info.Domain.Description);
        fprintf(fid, '| ID | Category | Domain |\n');
        fprintf(fid, '| :---: | :------: | :----: |\n');
        fprintf(fid, '|  %s  |  %s |  %s |\n\n', info.ID,info.Category,info.Domain.Title);    

        fprintf(fid, '%s\n\n',info.Description);

        % Add links if available
        if isfield(info, 'Site') && ~isempty(info.Site)
            fprintf(fid, '- [Official Site](%s)\n', info.Site);
        end
        if isfield(info, 'Docs') && ~isempty(info.Docs)
            fprintf(fid, '- [Documentation](%s)\n', info.Docs);
        end
        if isfield(info, 'Source') && ~isempty(info.Source)
            fprintf(fid, '- [Source Code](%s)\n', info.Source);
        end
        if isfield(info, 'Editor') && ~isempty(info.Editor)
            fprintf(fid, '- [Online Editor](%s)\n', info.Editor);
        end
        if isfield(info, 'Samples') && ~isempty(info.Samples)
            fprintf(fid, '- [Samples](%s)\n', info.Samples);
        end

        fclose(fid);
        fprintf('Wrote %s intro.mdx in: %s\n', info.ID, info.TargetDir);
    else
        warning('Could not write intro.mdx in %s', info.TargetDir);
    end
end
end
