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
- https://docs.kroki.io/kroki/setup/kroki-cli/

kroki.yml
```yml
endpoint: 'http://localhost:8000'
timeout: 30s
```

Set the Environment Variables

```bash
set KROKI_ENDPOINT=http://localhost:8000
set KROKI_TIMEOUT=15s
```

## Kroki POST

```bash
curl -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg
```

```bash
# Saves the output to diagram.svg
curl -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg > tests/hello.svg
```

## Base64

- https://di-mgt.com.au/base64-for-windows.html

```bash
curl -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg | base64
```