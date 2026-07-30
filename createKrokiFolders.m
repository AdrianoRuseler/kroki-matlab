function createKrokiFolders(toolsID)
    % createKrokiFolders builds folder structure based on tool IDs
    % Input: toolsID can be a single string or a cell array of strings

    % Normalize input to a cell array
    if ischar(toolsID) || isstring(toolsID)
        toolsID = {char(toolsID)};
    elseif ~iscell(toolsID)
        error('Input must be a string or a cell array of tool IDs');
    end

    % Loop through each tool ID
    for i = 1:numel(toolsID)
        % Get tool info (includes TargetDir now)
        info = getToolInfo(toolsID{i});

        % Create folder if it doesn't exist
        if ~exist(info.TargetDir, 'dir')
            mkdir(info.TargetDir);
            fprintf('Created folder: %s\n', info.TargetDir);
        else
            fprintf('Folder already exists: %s\n', info.TargetDir);
        end

        % Build samples folder path inside TargetDir
        samplesDir = fullfile(info.TargetDir, 'samples');
        % Create samples folder if it doesn't exist
        if ~exist(samplesDir, 'dir')
            mkdir(samplesDir);
            fprintf('Created samples folder: %s\n', samplesDir);
        else
            fprintf('Samples folder already exists: %s\n', samplesDir);
        end
    end
end
