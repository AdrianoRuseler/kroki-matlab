function info = getToolDescription(toolid)
% getToolDescription returns a human-readable description for each tool
% info = getToolDescription('mermaid')
switch lower(toolid)
    % --- General-Purpose & Multi-Paradigm ---
    case 'mermaid'
        info.desc = 'Markdown-inspired syntax for generating flowcharts, sequence diagrams, and charts.';
        info.site = 'https://mermaid.ai/open-source/';
        info.docs = 'https://mermaid.js.org/intro/';
        info.source = 'https://github.com/mermaid-js/mermaid';
        info.editor = 'https://mermaid.ai/live/';
        info.samples = 'https://mermaid.ai/open-source/ecosystem/tutorials.html';
        info.pos = '2';
    case 'plantuml'
        info.desc = 'Text-based language for creating UML diagrams and system architectures.';
        info.site = 'https://plantuml.com/';
        info.docs = 'https://plantuml.com/guide';
        info.source = 'https://github.com/plantuml/plantuml';
        info.editor = 'https://www.plantuml.com/plantuml/';
        info.samples = 'https://plantuml.com/';
        info.pos = '3';
    case {'graphviz','dot'}
        info.desc = 'Open-source graph visualization software using the DOT language.';
        info.site = 'https://www.graphviz.org/';
        info.docs = 'https://www.graphviz.org/documentation/';
        info.source = 'https://gitlab.com/graphviz/graphviz';
        info.editor = 'https://www.devtoolsdaily.com/graphviz/';
        info.samples = 'https://www.graphviz.org/gallery/';
        info.pos = '4';
    case 'd2'
        info.desc = 'Modern, declarative diagram scripting language.';
        info.site = 'https://d2lang.com/';
        info.docs = 'https://d2lang.com/tour/intro/';
        info.source = 'https://github.com/terrastruct/d2';
        info.editor = 'https://play.d2lang.com/';
        info.samples = 'https://d2lang.com/examples/overview/';
        info.pos = '5';
    case 'diagramsnet'
        info.desc = 'Open-source visual diagram editor engine (Draw.io).';
        info.site = 'https://www.drawio.com/';
        info.docs = 'https://www.drawio.com/docs/';
        info.source = 'https://github.com/jgraph/drawio';
        info.editor = 'https://app.diagrams.net/';
        info.samples = 'https://www.drawio.com/docs/tutorials/';
        info.pos = '6';
    case 'excalidraw'
        info.desc = 'Virtual whiteboard tool for hand-drawn, sketch-style diagrams.';
        info.site = 'https://plus.excalidraw.com';
        info.docs = 'https://plus.excalidraw.com/community';
        info.source = 'https://github.com/excalidraw/excalidraw';
        info.editor = 'https://excalidraw.com/';
        info.samples = 'https://plus.excalidraw.com/use-cases';
        info.pos = '7';
    case 'umlet'
        info.desc = 'Free, interactive UML diagram drawing tool.';
        info.site = 'https://www.umlet.com/';
        info.docs = 'https://www.umlet.com/';
        info.source = 'https://github.com/umlet/umlet';
        info.editor = 'https://www.umletino.com/';
        info.samples = 'https://www.umlet.com/';
        info.pos = '8';
    case 'tikz'
        info.desc = 'Programmatic graphics package for TeX/LaTeX.';
        info.site = 'https://github.com/pgf-tikz/pgf';
        info.docs = 'https://pgf-tikz.github.io/';
        info.source = 'https://github.com/pgf-tikz/pgf';
        info.editor = 'https://tikz.dev/editor/web/';
        info.samples = 'https://tikz.dev/';
        info.pos = '9';

        % --- Software Architecture & Modeling ---
    case 'c4plantuml'
        info.desc = 'PlantUML macros and extensions for rendering the C4 software architecture model.';
        info.site = 'https://github.com/plantuml-stdlib/C4-PlantUML';
        info.docs = 'https://github.com/plantuml-stdlib/C4-PlantUML';
        info.source = 'https://github.com/plantuml-stdlib/C4-PlantUML';
        info.editor = 'https://github.com/plantuml-stdlib/C4-PlantUML';
        info.samples = 'https://github.com/plantuml-stdlib/C4-PlantUML';
        info.pos = '2';
    case 'structurizr'
        info.desc = 'Tooling for visualizing and documenting software architecture based on the C4 model.';
        info.site = 'https://structurizr.com/';
        info.docs = 'https://docs.structurizr.com/dsl';
        info.source = 'https://github.com/structurizr/structurizr';
        info.editor = 'https://playground.structurizr.com/';
        info.samples = 'https://docs.structurizr.com/dsl/example';
        info.pos = '3';
    case 'nomnoml'
        info.desc = 'Lightweight tool for drawing UML class diagrams from simple grammar.';
        info.site = 'https://www.nomnoml.com/';
        info.docs = 'https://www.nomnoml.com/';
        info.source = 'https://github.com/skanaar/nomnoml';
        info.editor = 'https://www.nomnoml.com/';
        info.samples = 'https://www.nomnoml.com/';
        info.pos = '4';

        % --- Network, Infrastructure & Layouts ---
    case 'blockdiag'
        info.desc = 'Block diagram generation tool.';
        info.site = 'http://blockdiag.com/en/blockdiag/index.html';
        info.docs = 'http://blockdiag.com/en/blockdiag/index.html';
        info.source = 'https://github.com/yuzutech/blockdiag';
        info.editor = 'http://interactive.blockdiag.com/';
        info.samples = 'http://blockdiag.com/en/blockdiag/index.html';
        info.pos = '2';
    case 'actdiag'
        info.desc = 'Activity diagram generator.';
        info.site = 'http://blockdiag.com/en/actdiag/index.html';
        info.docs = 'http://blockdiag.com/en/actdiag/index.html';
        info.source = 'https://github.com/blockdiag/actdiag';
        info.editor = 'http://interactive.blockdiag.com/';
        info.samples = 'http://blockdiag.com/en/actdiag/demo.html';
        info.pos = '3';
    case 'nwdiag'
        info.desc = 'Network diagram generator.';
        info.site = 'http://blockdiag.com/en/nwdiag/index.html';
        info.docs = 'http://blockdiag.com/en/nwdiag/index.html';
        info.source = 'https://github.com/blockdiag/nwdiag';
        info.editor = 'http://interactive.blockdiag.com/';
        info.samples = 'http://blockdiag.com/en/nwdiag/nwdiag-examples.html';
        info.pos = '4';
    case 'rackdiag'
        info.desc = 'Server rack layout diagram generator.';
        info.site = 'http://blockdiag.com/en/nwdiag/index.html';
        info.docs = 'http://blockdiag.com/en/nwdiag/index.html';
        info.source = 'https://github.com/blockdiag/nwdiag';
        info.editor = 'http://blockdiag.com/en/rackdiag/demo.html';
        info.samples = 'http://blockdiag.com/en/nwdiag/rackdiag-examples.html';
        info.pos = '5';
    case 'packetdiag'
        info.desc = 'Network packet structure diagram generator.';
        info.site = 'http://blockdiag.com/en/nwdiag/index.html';
        info.docs = 'http://blockdiag.com/en/nwdiag/index.html';
        info.source = 'https://github.com/blockdiag/nwdiag';
        info.editor = 'http://interactive.blockdiag.com/';
        info.samples = 'http://blockdiag.com/en/nwdiag/nwdiag-examples.html';
        info.pos = '6';
    case 'seqdiag'
        info.desc = 'Sequence diagram generator.';
        info.site = 'http://blockdiag.com/en/seqdiag/index.html';
        info.docs = 'http://blockdiag.com/en/seqdiag/index.html';
        info.source = 'https://github.com/blockdiag/seqdiag';
        info.editor = 'http://interactive.blockdiag.com/';
        info.samples = 'http://blockdiag.com/en/seqdiag/demo.html';
        info.pos = '7';
    case 'wireviz'
        info.desc = 'Documentation tool for cables, wiring harnesses, and pinout diagrams.';
        info.site = 'https://github.com/wireviz/WireViz';
        info.docs = 'https://github.com/wireviz/WireViz';
        info.source = 'https://github.com/wireviz/WireViz';
        info.editor = 'https://github.com/wireviz/WireViz';
        info.samples = 'https://github.com/wireviz/WireViz';
        info.pos = '8';

        % --- Databases & Entity Relationships ---
    case 'dbml'
        info.desc = 'Database Markup Language for defining and documenting relational database schemas.';
        info.site = 'https://dbml.dbdiagram.io/home';
        info.docs = 'https://dbml.dbdiagram.io/home';
        info.source = 'https://github.com/softwaretechnik-berlin/dbml-renderer';
        info.editor = 'https://dbml.dbdiagram.io/playground/';
        info.samples = 'https://github.com/softwaretechnik-berlin/dbml-renderer/';
        info.pos = '2';
    case 'erd'
        info.desc = 'Entity-Relationship diagram generator.';
        info.site = 'https://github.com/BurntSushi/erd';
        info.docs = 'https://github.com/BurntSushi/erd';
        info.source = 'https://github.com/BurntSushi/erd';
        info.editor = 'https://github.com/BurntSushi/erd';
        info.samples = 'https://github.com/BurntSushi/erd';
        info.pos = '3';

        % --- Hardware, Timing & Protocols ---
    case 'wavedrom'
        info.desc = 'JavaScript/JSON-based digital timing diagram rendering engine.';
        info.site = 'https://wavedrom.com/';
        info.docs = 'https://wavedrom.com/tutorial.html';
        info.source = 'https://github.com/wavedrom/wavedrom';
        info.editor = 'https://wavedrom.com/editor.html';
        info.samples = 'https://wavedrom.com/tutorial.html';
        info.pos = '2';
    case 'bytefield'
        info.desc = 'Tool for generating network protocol and memory layout packet diagrams.';
        info.site = 'https://bytefield-svg.deepsymmetry.org/bytefield-svg/intro.html';
        info.docs = 'https://bytefield-svg.deepsymmetry.org/bytefield-svg/intro.html';
        info.source = 'https://github.com/Deep-Symmetry/bytefield-svg/';
        info.editor = 'https://github.com/Deep-Symmetry/bytefield-svg';
        info.samples = 'https://bytefield-svg.deepsymmetry.org/bytefield-svg/examples.html';
        info.pos = '3';
    case 'symbolator'
        info.desc = 'Schematic symbol generator from HDL (Hardware Description Language) code.';
        info.site = 'https://kevinpt.github.io/symbolator/';
        info.docs = 'http://kevinpt.github.io/symbolator/';
        info.source = 'https://github.com/kevinpt/symbolator';
        info.editor = 'http://kevinpt.github.io/symbolator/';
        info.samples = 'http://kevinpt.github.io/symbolator/';
        info.pos = '4';

        % --- Data Visualization ---
    case 'vega'
        info.desc = 'Visualization grammar for declarative interactive graphics.';
        info.site = 'https://vega.github.io/vega/';
        info.docs = 'https://vega.github.io/vega/docs/';
        info.source = 'https://github.com/vega/vega';
        info.editor = 'https://vega.github.io/editor/';
        info.samples = 'https://vega.github.io/vega/examples/';
        info.pos = '2';
    case 'vegalite'
        info.desc = 'High-level specification grammar built on top of Vega.';
        info.site = 'https://vega.github.io/vega-lite/';
        info.docs = 'https://vega.github.io/vega-lite/docs/';
        info.source = 'https://github.com/vega/vega-lite';
        info.editor = 'https://vega.github.io/editor/';
        info.samples = 'https://vega.github.io/vega-lite/examples/';
        info.pos = '3';

        % --- ASCII Art, Text-to-SVG & Aggregators ---
    case 'ditaa'
        info.desc = 'Converts ASCII art text diagrams into clean vector graphics.';
        info.site = 'https://ditaa.sourceforge.net/';
        info.docs = 'http://ditaa.sourceforge.net';
        info.source = 'https://sourceforge.net/p/ditaa/svn/HEAD/tree/';
        info.editor = 'https://ditaa.sourceforge.net/';
        info.samples = 'https://ditaa.sourceforge.net/';
        info.pos = '2';
    case 'svgbob'
        info.desc = 'Converts ASCII art diagrams into pristine SVG.';
        info.site = 'https://github.com/ivanceras/svgbob';
        info.docs = 'https://github.com/ivanceras/svgbob';
        info.source = 'https://github.com/ivanceras/svgbob';
        info.editor = 'https://ivanceras.github.io/svgbob-editor/';
        info.samples = 'https://github.com/ivanceras/svgbob';
        info.pos = '3';
    case 'goat'
        info.desc = 'Go-based ASCII-to-SVG diagram parser and renderer.';
        info.site = 'https://github.com/blampe/goat';
        info.docs = 'https://github.com/blampe/goat';
        info.source = 'https://github.com/blampe/goat';
        info.editor = 'https://github.com/blampe/goat';
        info.samples = 'https://github.com/blampe/goat';
        info.pos = '4';
    case 'pikchr'
        info.desc = 'PIC-inspired markup language for technical diagrams.';
        info.site = 'https://pikchr.org/home/doc/trunk/homepage.md';
        info.docs = 'https://pikchr.org/home/doc/trunk/homepage.md';
        info.source = 'https://github.com/drhsqlite/pikchr';
        info.editor = 'https://pikchr.org/home/pikchrshow';
        info.samples = 'https://pikchr.org/home/doc/trunk/doc/examples.md';
        info.pos = '5';
    case 'bpmn'
        info.desc = 'Business Process Model and Notation rendering engine.';
        info.site = 'https://bpmn.io/toolkit/bpmn-js/';
        info.docs = 'https://bpmn.io/toolkit/bpmn-js/walkthrough/';
        info.source = 'https://github.com/bpmn-io/bpmn-js';
        info.editor = 'https://demo.bpmn.io/';
        info.samples = 'https://bpmn.io/toolkit/bpmn-js/examples/';
        info.pos = '6';
    case 'kroki'
        info.desc = 'Unified meta-aggregator API service that hosts and runs all diagramming tools.';
        info.site = 'https://kroki.io/';
        info.docs = 'https://docs.kroki.io/kroki/';
        info.source = 'https://github.com/yuzutech/kroki';
        info.editor = 'https://niolesk.top/';
        info.samples = 'https://kroki.io/#examples';
        info.pos = '7';

    otherwise
        info.desc = '';
        info.site = '';
        info.docs = '';
        info.source = '';
        info.editor = '';
        info.samples = '';
        info.pos = '';
end
end

