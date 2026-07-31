function generateSamplesMdx(toolsID)
    % generateSamplesMdx creates samples.mdx for one or more tools
    % Displays source code and linked SVG image for each sample
    %
    % Input: toolsID (string or cell array of strings)
    %
    % Example: generateSamplesMdx({'dot','mermaid','plantuml'})

    % Normalize input to a cell array
    if ischar(toolsID) || isstring(toolsID)
        toolsID = {char(toolsID)};
    elseif ~iscell(toolsID)
        error('toolsID must be a string or a cell array of tool IDs');
    end

    % Loop through each tool ID
    for t = 1:numel(toolsID)
        toolID = char(toolsID{t});
        info = getToolInfo(toolID);

        % Ensure samples folder exists
        samplesDir = fullfile(info.TargetDir, 'samples');
        if ~exist(samplesDir, 'dir')
            warning('Samples folder does not exist: %s', samplesDir);
            continue;
        end

        % Get samples (struct array with FileName, Content, SvgExists)
        samples = getToolSample(toolID);

        % Path for samples.mdx
        mdxPath = fullfile(info.TargetDir, 'samples.mdx');

        % Write MDX file
        fid = fopen(mdxPath, 'w');
        if fid == -1
            warning('Could not create samples.mdx in %s', info.TargetDir);
            continue;
        end

        % Header
        fprintf(fid, '# Samples\n\n');

        % Loop through samples
        for i = 1:numel(samples)
            fprintf(fid, '## %s\n\n', samples(i).FileName);

            % Source code block
            fprintf(fid, '```%s\n', info.ID);
            fprintf(fid, '%s\n', samples(i).Content);
            fprintf(fid, '```\n\n');

            % If SVG exists, embed image
            if samples(i).SvgExists
                [~, name, ~] = fileparts(samples(i).FileName);
                svgFile = [name '.svg'];
                fprintf(fid, '![%s](./samples/%s)\n\n', name, svgFile);
            end
        end

        fclose(fid);
        fprintf('Created samples.mdx in: %s\n', info.TargetDir);
    end
end
