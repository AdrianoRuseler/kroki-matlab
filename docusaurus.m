clc
clear all

[toolsID, toolsName, cmdout] = getkrokitools(true);   % local Kroki
% [toolsID, toolsName, cmdout] = getkrokitools(false);  % remote Kroki

% getToolInfo returns Name, Category, and Domain metadata for tool IDs
toolInfos = getToolInfo(toolsID);


toolInfos = getToolInfo('dot');
addToolIntro('dot'); 
% getToolTable returns a summary table for a list of tool IDs
toolTable = getToolTable(toolsID);

% getToolInfo('mermaid')

createKrokiFolders(toolsID)
addToolIntro(toolsID); 
addToolCategoryJson(toolsID)

addDomainIntroMdx()

domainKeys = {'general','architecture','infrastructure','database','hardware','dataviz','ascii'};
AddNavBar(domainKeys)


generateToolSvgs(toolsID)

% copyToolSamples('dot')
copyToolSamples(toolsID)

% https://github.com/mermaid-js/mermaid
% activityInfo = getGitHubRepoActivity('mermaid-js', 'mermaid')



% for t=1:numel(toolInfos)
%     createKrokiFolders(toolsID{t})
% end

% Creates kroki-docs/general/dot

createKrokiFolders('dot');      % make sure folder exists
addToolReadme('dot');           % adds README.md inside kroki-docs/general/dot

createKrokiFolders({'plantuml','dbml'});
addToolReadme({'plantuml','dbml'});

addToolReadme('dot');

% samples = getToolSample('dot');

generateSamplesMdx(toolsID)

addToolCategoryJson('dot')


info = getToolDescription('dot')

samples = getToolSample('dot');

disp(samples)

%% 

disp('--- All Tool Versions ---');
for i = 1:length(toolNames)
    tool = toolNames{i};

    % Retrieve the value using the tool name variable
    toolVersion = versionStruct.(tool);

    % Handle the nested 'kroki' field which is another structure
    if isstruct(toolVersion)
        toolVersion = toolVersion.number; % Extract the 'number' field
    end

    disp([tool, ': ', toolVersion]);

    targetDir = fullfile('docku/', tool);
    if ~isfolder(targetDir)
        mkdir(targetDir);
    end
end

% Create README.md file in each targetDir
for i = 1:length(toolNames)
    tool = toolNames{i};
    targetDir = fullfile('docku/', tool);
    readmePath = fullfile(targetDir, 'README.mdx');
    disp(readmePath)
    fid = fopen(readmePath, 'w');
    if fid ~= -1
        toolVersion = versionStruct.(tool);
        % Handle the nested 'kroki' field which is another structure
        if isstruct(toolVersion)
            fprintf(fid, '# %s\n\nVersion: %s\n', tool, toolVersion.number);
        else
            fprintf(fid, '# %s\n\nVersion: %s\n', tool, toolVersion);
        end
        fclose(fid);
    else
        disp(['Error creating README.mdx for ', tool]);
    end
end

%%

for i = 1:length(toolNames)
    tool = toolNames{i};

    % Retrieve the version value safely
    toolVersion = versionStruct.(tool);
    if isstruct(toolVersion)
        toolVersion = toolVersion.number; 
    end
    disp([tool, ': ', toolVersion]);

    % Use a switch statement to select the appropriate group folder
    switch tool
        case {'mermaid', 'plantuml', 'graphviz', 'dot', 'd2', 'diagramsnet', 'excalidraw', 'umlet', 'tikz'}
            categoryFolder = 'docs-general';

        case {'c4plantuml', 'structurizr', 'nomnoml'}
            categoryFolder = 'docs-architecture';

        case {'blockdiag', 'actdiag', 'nwdiag', 'rackdiag', 'packetdiag', 'seqdiag', 'wireviz'}
            categoryFolder = 'docs-infrastructure';

        case {'dbml', 'erd'}
            categoryFolder = 'docs-database';

        case {'wavedrom', 'bytefield', 'symbolator'}
            categoryFolder = 'docs-hardware';

        case {'vega', 'vegalite'}
            categoryFolder = 'docs-dataviz';

        case {'ditaa', 'svgbob', 'goat', 'pikchr', 'bpmn'}
            categoryFolder = 'docs-ascii';

        otherwise
            categoryFolder = 'docs-otherwise'; % Fallback default folder
    end

    % Create target directory under the specific documentation instance and tool name
    targetDir = fullfile('kroki-docs/', categoryFolder, tool);
    if ~isfolder(targetDir)
        mkdir(targetDir);
    end
    % Create or overwrite the intro.mdx file inside each tool directory
    introFilePath = fullfile(targetDir, 'intro.mdx');
    fid = fopen(introFilePath, 'w', 'n', 'UTF-8');
    if fid ~= -1
        fprintf(fid, '---\n');
        fprintf(fid, 'sidebar_label: Overview\n');
        fprintf(fid, 'sidebar_position: 1\n');
        fprintf(fid, '---\n\n');
        fprintf(fid, '# %s\n\n', tool);
        fprintf(fid, 'Welcome to the documentation for **%s** (Version: `%s`).\n\n', tool, string(toolVersion));
        fprintf(fid, '## Overview\n\n');
        fprintf(fid, 'This section covers the syntax specifications, usage guidelines, and examples for rendering diagrams and documents using %s via Kroki.\n\n', tool);
        fprintf(fid, ':::note\n');
        fprintf(fid, 'This document is automatically generated and managed within the %s category instance.\n', categoryFolder);
        fprintf(fid, ':::\n');
        fclose(fid);
    else
        warning('Could not create intro.mdx for tool: %s', tool);
    end

% 1. Create or overwrite the _category_.json file
    categoryJsonPath = fullfile(targetDir, '_category_.json');
    fidJson = fopen(categoryJsonPath, 'w', 'n', 'UTF-8');
    if fidJson ~= -1
        fprintf(fidJson, '{\n');
        fprintf(fidJson, '  "label": "%s",\n', tool);
        fprintf(fidJson, '  "position": %d,\n', i);
        fprintf(fidJson, '  "link": {\n');
        fprintf(fidJson, '    "type": "generated-index",\n');
        fprintf(fidJson, '    "description": "%s related documentation and resources."\n', tool);
        fprintf(fidJson, '  }\n');
        fprintf(fidJson, '}\n');
        fclose(fidJson);
    else
        warning('Could not create _category_.json for tool: %s', tool);
    end
end

%% Home Page

% Define domains and their corresponding folders and descriptions
domains = struct( ...
    'Key', {'general', 'architecture', 'infrastructure', 'database', 'hardware', 'dataviz', 'ascii'}, ...
    'Title', {'General', 'Architecture', 'Infrastructure', 'Database', 'Hardware', 'Data Visualization', 'ASCII & Tools'}, ...
    'Description', { ...
        'General-Purpose & Multi-Paradigm.', ...
        'Software Architecture & Modeling.', ...
        'Network, Infrastructure & Layouts.', ...
        'Databases & Entity Relationships.', ...
        'Hardware, Timing & Protocols.', ...
        'Data Visualization.', ...
        'ASCII Art, Text-to-SVG & Ecosystem Aggregators.' ...
    } ...
);

% Map each tool to its domain key
domainMap = containers.Map({ ...
    'mermaid', 'plantuml', 'graphviz', 'dot', 'd2', 'diagramsnet', 'excalidraw', 'umlet', 'tikz', ...
    'c4plantuml', 'structurizr', 'nomnoml', ...
    'blockdiag', 'actdiag', 'nwdiag', 'rackdiag', 'packetdiag', 'seqdiag', 'wireviz', ...
    'dbml', 'erd', ...
    'wavedrom', 'bytefield', 'symbolator', ...
    'vega', 'vegalite', ...
    'ditaa', 'svgbob', 'goat', 'pikchr', 'bpmn', 'kroki' ...
}, { ...
    'general', 'general', 'general', 'general', 'general', 'general', 'general', 'general', 'general', ...
    'architecture', 'architecture', 'architecture', ...
    'infrastructure', 'infrastructure', 'infrastructure', 'infrastructure', 'infrastructure', 'infrastructure', 'infrastructure', ...
    'database', 'database', ...
    'hardware', 'hardware', 'hardware', ...
    'dataviz', 'dataviz', ...
    'ascii', 'ascii', 'ascii', 'ascii', 'ascii', 'ascii' ...
});

% List of Docusaurus SVG placeholders to cycle through
svgAssets = { ...
    'require(''@site/static/img/undraw_docusaurus_mountain.svg'').default', ...
    'require(''@site/static/img/undraw_docusaurus_tree.svg'').default', ...
    'require(''@site/static/img/undraw_docusaurus_react.svg'').default' ...
};

% Initialize a containers.Map to group tools by domain key
groupedSections = containers.Map();
for d = 1:length(domains)
    groupedSections(domains(d).Key) = {};
end

% Populate grouped tools
for i = 1:length(toolNames)
    tool = toolNames{i};
    if isKey(domainMap, tool)
        dKey = domainMap(tool);
    else
        dKey = 'ascii'; % Fallback
    end
    
    currentList = groupedSections(dKey);
    currentList{end+1} = tool;
    groupedSections(dKey) = currentList;
end

% Generate the structured output format
outputFilePath = 'featuresConfig.js';
fid = fopen(outputFilePath, 'w', 'n', 'UTF-8');

if fid ~= -1
    fprintf(fid, 'const sections = [\n');
    
    for d = 1:length(domains)
        dKey = domains(d).Key;
        dTitle = domains(d).Title;
        dDesc = domains(d).Description;
        toolsInDomain = groupedSections(dKey);
        
        if isempty(toolsInDomain)
            continue;
        end
        
        fprintf(fid, '  {\n');
        fprintf(fid, '    sectionTitle: "%s",\n', dTitle);
        fprintf(fid, '    sectionDescription: "%s",\n', dDesc);
        fprintf(fid, '    sectionLink: "/%s/intro",\n', dKey);
        fprintf(fid, '    features: [\n');
        
        for t = 1:length(toolsInDomain)
            tool = toolsInDomain{t};
            
            % Retrieve version safely if needed
            toolVersion = '';
            if isfield(versionStruct, tool)
                toolVersion = versionStruct.(tool);
                if isstruct(toolVersion)
                    toolVersion = toolVersion.number;
                end
            end
            
            % Pick an SVG asset cyclically
            svgAsset = svgAssets{mod(t-1, length(svgAssets)) + 1};
            
            fprintf(fid, '      {\n');
            fprintf(fid, '        title: ''%s'',\n', tool);
            fprintf(fid, '        Svg: %s,\n', svgAsset);
            fprintf(fid, '        description: ''Description for %s feature (v%s).'',\n', tool, string(toolVersion));
            fprintf(fid, '        link: ''/%s/%s/intro'',\n', dKey, tool);
            fprintf(fid, '      },\n');
        end
        
        fprintf(fid, '    ],\n');
        fprintf(fid, '  },\n');
    end
    
    fprintf(fid, '];\n\n');
    fprintf(fid, 'export default sections;\n');
    fclose(fid);
    disp(['Successfully generated features configuration at: ', outputFilePath]);
else
    warning('Could not open file for writing: %s', outputFilePath);
end

