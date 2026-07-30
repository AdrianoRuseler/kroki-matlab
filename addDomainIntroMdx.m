function addDomainIntroMdx()
    % addDomainIntroMdx creates intro.mdx file for each domain category
    % Uses getCategoryInfo to fetch domain metadata and tools

    % Define all domain keys
    domainKeys = {'general','architecture','infrastructure','database','hardware','dataviz','ascii'};

    % Loop through each domain
    for i = 1:numel(domainKeys)
        % Get domain + tools info
        catInfo = getCategoryInfo(domainKeys{i});

        % Target directory for domain intro
        targetDir = fullfile('kroki-docs', ['docs-' catInfo.CategoryKey]);

        % Ensure folder exists
        if ~exist(targetDir, 'dir')
            mkdir(targetDir);
            fprintf('Created folder: %s\n', targetDir);
        end

        % Path for intr.mdx
        introPath = fullfile(targetDir, 'intro.mdx');

        % Build MDX content header
        mdxContent = ['---' newline];
        mdxContent = [mdxContent 'sidebar_position: 1' newline];
        mdxContent = [mdxContent '---' newline];
        mdxContent = [mdxContent sprintf('\n# %s\n\n%s\n\n', catInfo.Domain.Title, catInfo.Domain.Description)];
        mdxContent = [mdxContent sprintf('This section contains documentation and resources for tools in the **%s** domain.\n\n', catInfo.Domain.Title)];

        % Add each tool info
        for j = 1:numel(catInfo.Tools)
            tool = catInfo.Tools{j};
            mdxContent = [mdxContent sprintf('## %s\n\n', tool.Name)];
            mdxContent = [mdxContent sprintf('**ID:** %s\n\n', tool.ID)];
            mdxContent = [mdxContent sprintf('**Description:** %s\n\n', tool.Description)];

            % Add links if available
            if isfield(tool, 'Site') && ~isempty(tool.Site)
                mdxContent = [mdxContent sprintf('- [Official Site](%s)\n', tool.Site)];
            end
            if isfield(tool, 'Docs') && ~isempty(tool.Docs)
                mdxContent = [mdxContent sprintf('- [Documentation](%s)\n', tool.Docs)];
            end
            if isfield(tool, 'Source') && ~isempty(tool.Source)
                mdxContent = [mdxContent sprintf('- [Source Code](%s)\n', tool.Source)];
            end
            if isfield(tool, 'Editor') && ~isempty(tool.Editor)
                mdxContent = [mdxContent sprintf('- [Online Editor](%s)\n', tool.Editor)];
            end
            if isfield(tool, 'Samples') && ~isempty(tool.Samples)
                mdxContent = [mdxContent sprintf('- [Samples](%s)\n', tool.Samples)];
            end
            mdxContent = [mdxContent newline];
        end

        % Write file
        fid = fopen(introPath, 'w');
        if fid ~= -1
            fprintf(fid, '%s', mdxContent);
            fclose(fid);
            fprintf('Wrote intro.mdx in: %s\n', targetDir);
        else
            warning('Could not write intro.mdx in %s', targetDir);
        end
    end
end
