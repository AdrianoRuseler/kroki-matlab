function info = getCategoryInfo(key)
% getCategoryInfo returns domain metadata + all tools info for a given category
% Example: info = getCategoryInfo('infrastructure')

    % Define domain metadata
    domains.Key = {'general','architecture','infrastructure','database','hardware','dataviz','ascii'};
    domains.Title = {'General','Architecture','Infrastructure','Database','Hardware','Data Visualization','ASCII & Tools'};
    domains.Description = { ...
        'General-Purpose & Multi-Paradigm diagramming tools.', ...
        'Software Architecture & Modeling tools.', ...
        'Network, Infrastructure & Layout diagramming tools.', ...
        'Databases & Entity Relationship diagramming tools.', ...
        'Hardware, Timing & Protocol diagramming tools.', ...
        'Data Visualization grammars and engines.', ...
        'ASCII Art, Text-to-SVG converters, and ecosystem aggregators.' ...
    };

    % Define mapping of categories to tool IDs
    categoryTools.general = {'mermaid','plantuml','graphviz','dot','d2','diagramsnet','excalidraw','umlet','tikz'};
    categoryTools.architecture = {'c4plantuml','structurizr','nomnoml'};
    categoryTools.infrastructure = {'blockdiag','actdiag','nwdiag','rackdiag','packetdiag','seqdiag','wireviz'};
    categoryTools.database = {'dbml','erd'};
    categoryTools.hardware = {'wavedrom','bytefield','symbolator'};
    categoryTools.dataviz = {'vega','vegalite'};
    categoryTools.ascii = {'ditaa','svgbob','goat','pikchr','bpmn','kroki'};

    % Validate input
    if ~isfield(categoryTools, key)
        error('Unknown category key: %s', key);
    end

    % Get domain metadata
    idx = find(strcmp(domains.Key, key), 1);
    if isempty(idx)
        domainInfo = struct('Title','Other','Description','Uncategorized tools.');
    else
        domainInfo = struct('Title', domains.Title{idx}, 'Description', domains.Description{idx});
    end

    % Get tool IDs for this category
    toolsID = categoryTools.(key);

    % Collect info for each tool
    toolsInfo = cell(size(toolsID));
    for i = 1:numel(toolsID)
        toolsInfo{i} = getToolInfo(toolsID{i});
    end

    % Return combined struct
    info = struct( ...
        'CategoryKey', key, ...
        'Domain', domainInfo, ...
        'Tools', {toolsInfo} ...
    );
end
