const FEATURE_SECTIONS: FeatureSection[] = [
  
{
    sectionTitle: 'General',
    sectionDescription: 'General-Purpose & Multi-Paradigm diagramming tools.',
    sectionLink: '/general/intro',
    features: [
      {
        title: 'Mermaid',
        Svg: require('@site/static/img/tools/mermaid.svg').default,
        description: 'Markdown-inspired syntax for generating flowcharts, sequence diagrams, and charts.',
        link: '/general/mermaid/intro',
      },
      {
        title: 'PlantUML',
        Svg: require('@site/static/img/tools/plantuml.svg').default,
        description: 'Text-based language for creating UML diagrams and system architectures.',
        link: '/general/plantuml/intro',
      },
      {
        title: 'Graphviz',
        Svg: require('@site/static/img/tools/graphviz.svg').default,
        description: 'Open-source graph visualization software using the DOT language.',
        link: '/general/graphviz/intro',
      },
      {
        title: 'Graphviz DOT',
        Svg: require('@site/static/img/tools/dot.svg').default,
        description: 'Open-source graph visualization software using the DOT language.',
        link: '/general/dot/intro',
      },
      {
        title: 'D2',
        Svg: require('@site/static/img/tools/d2.svg').default,
        description: 'Modern, declarative diagram scripting language.',
        link: '/general/d2/intro',
      },
      {
        title: 'Diagrams.net',
        Svg: require('@site/static/img/tools/diagramsnet.svg').default,
        description: 'Open-source visual diagram editor engine (Draw.io).',
        link: '/general/diagramsnet/intro',
      },
      {
        title: 'Excalidraw',
        Svg: require('@site/static/img/tools/excalidraw.svg').default,
        description: 'Virtual whiteboard tool for hand-drawn, sketch-style diagrams.',
        link: '/general/excalidraw/intro',
      },
      {
        title: 'UMLet',
        Svg: require('@site/static/img/tools/umlet.svg').default,
        description: 'Free, interactive UML diagram drawing tool.',
        link: '/general/umlet/intro',
      },
      {
        title: 'TikZ',
        Svg: require('@site/static/img/tools/tikz.svg').default,
        description: 'Programmatic graphics package for TeX/LaTeX.',
        link: '/general/tikz/intro',
      },
    ],
  },
  
{
    sectionTitle: 'Architecture',
    sectionDescription: 'Software Architecture & Modeling tools.',
    sectionLink: '/architecture/intro',
    features: [
      {
        title: 'C4-PlantUML',
        Svg: require('@site/static/img/tools/c4plantuml.svg').default,
        description: 'PlantUML macros and extensions for rendering the C4 software architecture model.',
        link: '/architecture/c4plantuml/intro',
      },
      {
        title: 'Structurizr',
        Svg: require('@site/static/img/tools/structurizr.svg').default,
        description: 'Tooling for visualizing and documenting software architecture based on the C4 model.',
        link: '/architecture/structurizr/intro',
      },
      {
        title: 'Nomnoml',
        Svg: require('@site/static/img/tools/nomnoml.svg').default,
        description: 'Lightweight tool for drawing UML class diagrams from simple grammar.',
        link: '/architecture/nomnoml/intro',
      },
    ],
  },
  
{
    sectionTitle: 'Infrastructure',
    sectionDescription: 'Network, Infrastructure & Layout diagramming tools.',
    sectionLink: '/infrastructure/intro',
    features: [
      {
        title: 'BlockDiag',
        Svg: require('@site/static/img/tools/blockdiag.svg').default,
        description: 'Block diagram generation tool.',
        link: '/infrastructure/blockdiag/intro',
      },
      {
        title: 'ActDiag',
        Svg: require('@site/static/img/tools/actdiag.svg').default,
        description: 'Activity diagram generator.',
        link: '/infrastructure/actdiag/intro',
      },
      {
        title: 'NwDiag',
        Svg: require('@site/static/img/tools/nwdiag.svg').default,
        description: 'Network diagram generator.',
        link: '/infrastructure/nwdiag/intro',
      },
      {
        title: 'RackDiag',
        Svg: require('@site/static/img/tools/rackdiag.svg').default,
        description: 'Server rack layout diagram generator.',
        link: '/infrastructure/rackdiag/intro',
      },
      {
        title: 'PacketDiag',
        Svg: require('@site/static/img/tools/packetdiag.svg').default,
        description: 'Network packet structure diagram generator.',
        link: '/infrastructure/packetdiag/intro',
      },
      {
        title: 'SeqDiag',
        Svg: require('@site/static/img/tools/seqdiag.svg').default,
        description: 'Sequence diagram generator.',
        link: '/infrastructure/seqdiag/intro',
      },
      {
        title: 'Wireviz',
        Svg: require('@site/static/img/tools/wireviz.svg').default,
        description: 'Documentation tool for cables, wiring harnesses, and pinout diagrams.',
        link: '/infrastructure/wireviz/intro',
      },
    ],
  },
  
{
    sectionTitle: 'Database',
    sectionDescription: 'Databases & Entity Relationship diagramming tools.',
    sectionLink: '/database/intro',
    features: [
      {
        title: 'DBML',
        Svg: require('@site/static/img/tools/dbml.svg').default,
        description: 'Database Markup Language for defining and documenting relational database schemas.',
        link: '/database/dbml/intro',
      },
      {
        title: 'ERD',
        Svg: require('@site/static/img/tools/erd.svg').default,
        description: 'Entity-Relationship diagram generator.',
        link: '/database/erd/intro',
      },
    ],
  },
  
{
    sectionTitle: 'Hardware',
    sectionDescription: 'Hardware, Timing & Protocol diagramming tools.',
    sectionLink: '/hardware/intro',
    features: [
      {
        title: 'WaveDrom',
        Svg: require('@site/static/img/tools/wavedrom.svg').default,
        description: 'JavaScript/JSON-based digital timing diagram rendering engine.',
        link: '/hardware/wavedrom/intro',
      },
      {
        title: 'Bytefield',
        Svg: require('@site/static/img/tools/bytefield.svg').default,
        description: 'Tool for generating network protocol and memory layout packet diagrams.',
        link: '/hardware/bytefield/intro',
      },
      {
        title: 'Symbolator',
        Svg: require('@site/static/img/tools/symbolator.svg').default,
        description: 'Schematic symbol generator from HDL (Hardware Description Language) code.',
        link: '/hardware/symbolator/intro',
      },
    ],
  },
  
{
    sectionTitle: 'Data Visualization',
    sectionDescription: 'Data Visualization grammars and engines.',
    sectionLink: '/dataviz/intro',
    features: [
      {
        title: 'Vega',
        Svg: require('@site/static/img/tools/vega.svg').default,
        description: 'Visualization grammar for declarative interactive graphics.',
        link: '/dataviz/vega/intro',
      },
      {
        title: 'Vega-Lite',
        Svg: require('@site/static/img/tools/vegalite.svg').default,
        description: 'High-level specification grammar built on top of Vega.',
        link: '/dataviz/vegalite/intro',
      },
    ],
  },
  
{
    sectionTitle: 'ASCII & Tools',
    sectionDescription: 'ASCII Art, Text-to-SVG converters, and ecosystem aggregators.',
    sectionLink: '/ascii/intro',
    features: [
      {
        title: 'Ditaa',
        Svg: require('@site/static/img/tools/ditaa.svg').default,
        description: 'Converts ASCII art text diagrams into clean vector graphics.',
        link: '/ascii/ditaa/intro',
      },
      {
        title: 'SVGBob',
        Svg: require('@site/static/img/tools/svgbob.svg').default,
        description: 'Converts ASCII art diagrams into pristine SVG.',
        link: '/ascii/svgbob/intro',
      },
      {
        title: 'GoAT',
        Svg: require('@site/static/img/tools/goat.svg').default,
        description: 'Go-based ASCII-to-SVG diagram parser and renderer.',
        link: '/ascii/goat/intro',
      },
      {
        title: 'Pikchr',
        Svg: require('@site/static/img/tools/pikchr.svg').default,
        description: 'PIC-inspired markup language for technical diagrams.',
        link: '/ascii/pikchr/intro',
      },
      {
        title: 'BPMN',
        Svg: require('@site/static/img/tools/bpmn.svg').default,
        description: 'Business Process Model and Notation rendering engine.',
        link: '/ascii/bpmn/intro',
      },
      {
        title: 'Kroki',
        Svg: require('@site/static/img/tools/kroki.svg').default,
        description: 'Unified meta-aggregator API service that hosts and runs all diagramming tools.',
        link: '/ascii/kroki/intro',
      },
    ],
  },
];
