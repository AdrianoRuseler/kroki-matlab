function generateSamplesMdx(toolID)
% generateSamplesMdx creates samples.mdx for Docusaurus
% Displays source code and linked SVG image for each sample
%
% Input: toolID (string)

% Get tool info (includes TargetDir)
%  toolID = 'dot' % Test
info = getToolInfo(toolID);

% Ensure samples folder exists
samplesDir = fullfile(info.TargetDir, 'samples');
if ~exist(samplesDir, 'dir')
    warning('Samples folder does not exist: %s', samplesDir);
    return;
end

% Get samples
samples = getToolSample(toolID);

% Path for samples.mdx
mdxPath = fullfile(info.TargetDir, 'samples.mdx');

% Write MDX file
fid = fopen(mdxPath, 'w');
if fid == -1
    warning('Could not create samples.mdx in %s', info.TargetDir);
    return;
end

fprintf(fid, '# %s Samples\n\n', info.Name);

for i = 1:numel(samples)
    fprintf(fid, '## %s\n\n', samples(i).FileName);

    % Source code block
    fprintf(fid, '```%s\n', info.ID);
    fprintf(fid, '%s\n', samples(i).Content);
    fprintf(fid, '```\n\n');

    % If SVG exists, embed image
    if samples(i).SvgExists
        [filepath, name, ~] = fileparts(samples(i).FileName);
        svgFile = fullfile(filepath, [name '.svg']);
        fprintf(fid, '![%s](./samples/%s)\n\n', svgFile, svgFile);
    end
end

fclose(fid);
fprintf('Created samples.mdx in: %s\n', info.TargetDir);
end

