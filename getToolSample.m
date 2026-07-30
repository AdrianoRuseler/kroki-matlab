function sampleContent = getToolSample(toolID)
    % getToolSample reads sample files inside TargetDir/samples for a tool
    % Input: toolID (string)
    % Output: sampleContent (struct array with fields: FileName, Content, SvgExists)

    % Normalize toolID
    if isstring(toolID) || ischar(toolID)
        toolID = char(toolID);
    else
        error('toolID must be a string or char');
    end

    % Get tool info (includes TargetDir)
    info = getToolInfo(toolID);

    % Build samples folder path inside TargetDir
    samplesDir = fullfile(info.TargetDir, 'samples');

    % Check if folder exists
    if ~exist(samplesDir, 'dir')
        warning('Samples folder does not exist: %s', samplesDir);
        sampleContent = [];
        return;
    end

    % Get list of files in samplesDir
    files = dir(samplesDir);
    files = files(~[files.isdir]); % exclude subfolders

    % Read each file (only text-based ones)
    sampleContent = struct('FileName', {}, 'Content', {}, 'SvgExists', {});
    for i = 1:numel(files)
        filePath = fullfile(samplesDir, files(i).name);
        [~, baseName, ext] = fileparts(files(i).name);

        % Skip SVG files themselves
        if strcmpi(ext, '.svg')
            continue;
        end

        % Read text content
        fid = fopen(filePath, 'r');
        if fid ~= -1
            content = fread(fid, '*char')';
            fclose(fid);

            % Check if a matching SVG exists
            svgPath = fullfile(samplesDir, [baseName '.svg']);
            svgExists = exist(svgPath, 'file') == 2;

            sampleContent(end+1).FileName = files(i).name;
            sampleContent(end).Content = content;
            sampleContent(end).SvgExists = svgExists;
        else
            warning('Could not read file: %s', filePath);
        end
    end
end
