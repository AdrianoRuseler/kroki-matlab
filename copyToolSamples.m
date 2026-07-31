function copyToolSamples(toolsID)
    % copyToolSamples copies content from tests/toolID/ to TargetDir/samples
    % Skips *.md and *.mdx files
    % Input: toolsID can be a single string or a cell array of strings
    % Example: copyToolSamples({'dot','mermaid','plantuml'})

    % Normalize input to a cell array
    if ischar(toolsID) || isstring(toolsID)
        toolsID = {char(toolsID)};
    elseif ~iscell(toolsID)
        error('toolsID must be a string or a cell array of tool IDs');
    end

    % Loop through each tool ID
    for i = 1:numel(toolsID)
        toolID = char(toolsID{i});
        info = getToolInfo(toolID);

        % Source and destination paths
        srcDir = fullfile('tests', toolID);
        destDir = fullfile(info.TargetDir, 'samples');

        % Ensure source exists
        if ~exist(srcDir, 'dir')
            warning('Source folder does not exist: %s', srcDir);
            continue;
        end

        % Ensure destination exists
        if ~exist(destDir, 'dir')
            mkdir(destDir);
            fprintf('Created destination folder: %s\n', destDir);
        end

        % Copy files (skip .md and .mdx)
        files = dir(srcDir);
        for f = 1:numel(files)
            if ~files(f).isdir
                [~,~,ext] = fileparts(files(f).name);
                if strcmpi(ext,'.md') || strcmpi(ext,'.mdx')
                    fprintf('Skipped %s\n', files(f).name);
                    continue;
                end
                srcFile = fullfile(srcDir, files(f).name);
                destFile = fullfile(destDir, files(f).name);
                copyfile(srcFile, destFile);
                fprintf('Copied %s → %s\n', srcFile, destFile);
            end
        end
    end
end
