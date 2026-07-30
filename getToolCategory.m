function category = getToolCategory(toolid)
    % getToolCategory returns the category for a given tool ID or cell array of IDs
    % getToolCategory('plantuml')    % returns 'docs-general'

    % getToolCategory({'plantuml','dbml','wireviz'})   % returns {'docs-general','docs-database','docs-infrastructure'}

    % If input is a cell array, process each element
    if iscell(toolid)
        category = cell(size(toolid));
        for i = 1:numel(toolid)
            category{i} = getToolCategory(toolid{i}); % recursive call
        end
        return
    end

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

    % Otherwise, handle single string
    switch toolid
        case {'mermaid', 'plantuml', 'graphviz', 'dot', 'd2', 'diagramsnet', 'excalidraw', 'umlet', 'tikz'}
            category = 'docs-general';
            key='general';
            title=

        case {'c4plantuml', 'structurizr', 'nomnoml'}
            category = 'docs-architecture';

        case {'blockdiag', 'actdiag', 'nwdiag', 'rackdiag', 'packetdiag', 'seqdiag', 'wireviz'}
            category = 'docs-infrastructure';

        case {'dbml', 'erd'}
            category = 'docs-database';

        case {'wavedrom', 'bytefield', 'symbolator'}
            category = 'docs-hardware';

        case {'vega', 'vegalite'}
            category = 'docs-dataviz';

        case {'ditaa', 'svgbob', 'goat', 'pikchr', 'bpmn'}
            category = 'docs-ascii';

        otherwise
            category = 'docs-otherwise'; % Fallback default folder
    end
end
