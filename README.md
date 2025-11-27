# kroki-matlab

##  Kroki

- https://kroki.io/
- https://github.com/yuzutech/kroki
- https://docs.kroki.io/kroki/

Creates diagrams from textual descriptions!

Kroki provides a unified API with support for BlockDiag (BlockDiag, SeqDiag, ActDiag, NwDiag, PacketDiag, RackDiag), BPMN, Bytefield, C4 (with PlantUML), D2, DBML, Ditaa, Erd, Excalidraw, GraphViz, Mermaid, Nomnoml, Pikchr, PlantUML, Structurizr, SvgBob, Symbolator, TikZ, UMLet, Vega, Vega-Lite, WaveDrom, WireViz... and more to come!

## kroki-api

- http://localhost:8000/

```bash
docker compose up -d
```

```bash
docker compose down -v
```

## Kroki CLI
- https://github.com/yuzutech/kroki-cli

kroki.yml
```yml
endpoint: 'http://localhost:8000'
timeout: 30s
```