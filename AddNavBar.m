function AddNavBar(domainKeys)
    % AddNavBar generates a JSON-like navigation array for multiple domains
    % Example: AddNavBar({'general','architecture','infrastructure','database','hardware','dataviz','ascii'})

    % Validate input
    if ischar(domainKeys) || isstring(domainKeys)
        domainKeys = {char(domainKeys)};
    elseif ~iscell(domainKeys)
        error('domainKeys must be a string or a cell array of strings');
    end

    % Initialize navbar content
    navBar = "[\n";

    % Loop through each domain
    for d = 1:numel(domainKeys)
        % Get domain + tools info
        catInfo = getCategoryInfo(domainKeys{d});

        % Sort tools by Pos if available
        toolsArray = catInfo.Tools;
        if isfield(toolsArray{1}, 'Pos')
            % Extract positions
            positions = cellfun(@(x) x.Pos, toolsArray);
            [~, order] = sort(positions);
            toolsArray = toolsArray(order);
        end

        % Build domain block
        navBar = [navBar sprintf('{\n to: ''/%s/intro'',\n label: ''%s'',\n position: ''left'',\n type: ''dropdown'',\n items: [\n',catInfo.CategoryKey, catInfo.Domain.Title)];

        % Add items for each tool
        for i = 1:numel(toolsArray)
            tool = toolsArray{i};
            navBar = [navBar sprintf('        { to: ''/%s/%s/intro'', label: ''%s'' },\n', ...
                catInfo.CategoryKey, tool.ID, tool.Name)];
        end

        % Close domain block
        navBar = [navBar sprintf('        ],\n    },\n')];
    end

    % Close navbar array
    navBar = [navBar "]\n"];

    % Print to console
    fprintf('%s\n', navBar);

    % Optionally, write to file
    outPath = fullfile('kroki-docs', 'navbar.json');
    fid = fopen(outPath, 'w');
    if fid ~= -1
        fprintf(fid, '%s', navBar);
        fclose(fid);
        fprintf('Wrote NavBar JSON in: %s\n', outPath);
    else
        warning('Could not write NavBar JSON in %s', outPath);
    end
end
