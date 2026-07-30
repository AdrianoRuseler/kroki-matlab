function name = getToolName(id)
% getToolName returns a formatted name for a given tool identifier.
% Example:
%   getToolName('actdiag') -> 'ActDiag'
%   getToolName('diagramsnet') -> 'Diagrams.net'

% Define dictionary (containers.Map)
toolDict = containers.Map( ...
    { 'actdiag','bpmn','pikchr','nwdiag','c4plantuml','rackdiag','dot','symbolator','d2','tikz','mermaid','erd','graphviz','vegalite','ditaa','kroki','umlet','diagramsnet','plantuml','seqdiag','nomnoml','wavedrom','structurizr','bytefield','wireviz','goat','excalidraw','dbml','packetdiag','svgbob','vega','blockdiag' }, ...
    { 'ActDiag','BPMN','Pikchr','NwDiag','C4-PlantUML','RackDiag','Graphviz DOT','Symbolator','D2','TikZ','Mermaid','ERD','Graphviz','Vega-Lite','Ditaa','Kroki','UMLet','Diagrams.net','PlantUML','SeqDiag','Nomnoml','WaveDrom','Structurizr','Bytefield','Wireviz','GoAT','Excalidraw','DBML','PacketDiag','SVGBob','Vega','BlockDiag' } ...
    );

% Return formatted name if exists
if isKey(toolDict, id)
    name = toolDict(id);
else
    name = id; % fallback: return original
end
end
