function info = getToolInfo(toolid)
% getToolInfo returns Name, Category, and Domain metadata for tool IDs
% Supports both single string and cell array inputs
% toolInfos = getToolInfo('vega')
% toolInfos = getToolInfo({'dbml','wireviz','vega'})

% --- Define domains metadata as cell arrays ---
domains.Key = {'general','architecture','infrastructure','database','hardware','dataviz','ascii'};
domains.Title = {'General','Architecture','Infrastructure','Database','Hardware','Data Visualization','ASCII & Tools'};
domains.Description = { ...
    'General-Purpose & Multi-Paradigm.', ...
    'Software Architecture & Modeling.', ...
    'Network, Infrastructure & Layouts.', ...
    'Databases & Entity Relationships.', ...
    'Hardware, Timing & Protocols.', ...
    'Data Visualization.', ...
    'ASCII Art, Text-to-SVG & Ecosystem Aggregators.' ...
    };

% --- Handle cell array input ---
if iscell(toolid)
    info = cell(size(toolid));
    for i = 1:numel(toolid)
        info{i} = getToolInfo(toolid{i}); % recursive call
    end
    return
end

% --- Handle single string input ---
% Get formatted name
name = getToolName(toolid);

% Determine category key with if/else
if any(strcmp(toolid, {'mermaid','plantuml','graphviz','dot','d2','diagramsnet','excalidraw','umlet','tikz'}))
    category = 'general';
elseif any(strcmp(toolid, {'c4plantuml','structurizr','nomnoml'}))
    category = 'architecture';
elseif any(strcmp(toolid, {'blockdiag','actdiag','nwdiag','rackdiag','packetdiag','seqdiag','wireviz'}))
    category = 'infrastructure';
elseif any(strcmp(toolid, {'dbml','erd'}))
    category = 'database';
elseif any(strcmp(toolid, {'wavedrom','bytefield','symbolator'}))
    category = 'hardware';
elseif any(strcmp(toolid, {'vega','vegalite'}))
    category = 'dataviz';
elseif any(strcmp(toolid, {'ditaa','svgbob','goat','pikchr','bpmn'}))
    category = 'ascii';
else
    category = 'otherwise';
end

% --- Get domain metadata safely ---
idx = find(strcmp(domains.Key, category), 1);
if ~isempty(idx)
    domainInfo = struct('Title', domains.Title{idx}, 'Description', domains.Description{idx});
else
    domainInfo = struct('Title','Other','Description','Uncategorized tools.');
end

% --- Build targetDir ---
targetDir = fullfile('kroki-docs', ['docs-' category], toolid);

% --- Add description metadata ---
descInfo = getToolDescription(toolid);

% Merge everything
info = struct( ...
    'ID', toolid, ...
    'Name', name, ...
    'Category', category, ...
    'Domain', domainInfo, ...
    'TargetDir', targetDir, ...
    'Description', descInfo.desc, ...
    'Site', descInfo.site, ...
    'Docs', descInfo.docs, ...
    'Source', descInfo.source, ...
    'Editor', descInfo.editor, ...
    'Samples', descInfo.samples, ...
    'Pos', descInfo.pos ...
);
end
