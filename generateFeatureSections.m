function generateFeatureSections(domainKeys)
% generateFeatureSections creates a TypeScript constant FEATURE_SECTIONS
% Example: generateFeatureSections({'general','architecture','infrastructure','database','hardware','dataviz','ascii'})

% Normalize input
if ischar(domainKeys) || isstring(domainKeys)
    domainKeys = {char(domainKeys)};
elseif ~iscell(domainKeys)
    error('domainKeys must be a string or a cell array of strings');
end

% Initialize output
tsContent = ['const FEATURE_SECTIONS: FeatureSection[] = [' newline];

% Loop through each domain
for d = 1:numel(domainKeys)
    % Get domain + tools info
    catInfo = getCategoryInfo(domainKeys{d});

    % Domain block header
    tsContent = [tsContent sprintf( ...
        ['  \n{\n'  ...
        '    sectionTitle: ''%s'',\n'  ...
        '    sectionDescription: ''%s'',\n'  ...
        '    sectionLink: ''/%s/intro'',\n'  ...
        '    features: [\n'], ...
        catInfo.Domain.Title, catInfo.Domain.Description, catInfo.CategoryKey)];

    % Sort tools by Pos if available
    toolsArray = catInfo.Tools;
    if isfield(toolsArray{1}, 'Pos')
        positions = cellfun(@(x) x.Pos, toolsArray);
        [~, order] = sort(positions);
        toolsArray = toolsArray(order);
    end

    % Add each tool 
    for i = 1:numel(toolsArray)
        tool = toolsArray{i};
        tsContent = [tsContent sprintf( [...
            '      {\n'  ...
            '        title: ''%s'',\n'  ...
            '        Svg: require(''@site/static/img/tools/%s.svg'').default,\n'  ...
            '        description: ''%s'',\n'  ...
            '        link: ''/%s/%s/intro'',\n'  ...
            '      },\n'], ...
            tool.Name, tool.ID, tool.Description, catInfo.CategoryKey, tool.ID)];
    end

    % Close domain block
    tsContent = [ tsContent '    ],' newline '  },' newline];
    % disp(tsContent)
end

% Close array
tsContent = [tsContent '];' newline ];

% Print to console
% fprintf('%s\n', tsContent);

% Optionally, write to file
outPath = fullfile('kroki-docs', 'featureSections.ts');
fid = fopen(outPath, 'w');
if fid ~= -1
    fprintf(fid, '%s', tsContent);
    fclose(fid);
    fprintf('Wrote FEATURE_SECTIONS in: %s\n', outPath);
else
    warning('Could not write FEATURE_SECTIONS in %s', outPath);
end
end

