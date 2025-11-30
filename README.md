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

Get system info
```bash
curl -s http://localhost:8000/health
```

```json
{"version":{"actdiag":"3.1.0","bpmn":"18.6.1","pikchr":"7269f78c4a","nwdiag":"3.1.0","c4plantuml":"1.2025.2","rackdiag":"3.1.0","dot":"9.0.0","symbolator":"1.2.2","d2":"0.7.0","tikz":"3.1.9a","mermaid":"11.6.0","erd":"0.2.3","graphviz":"9.0.0","vegalite":"5.23.0","ditaa":"1.0.3","kroki":{"number":"0.28.0","build_hash":"1529df2"},"umlet":"15.1","diagramsnet":"16.2.4","plantuml":"1.2025.2","seqdiag":"3.1.0","nomnoml":"1.7.0","wavedrom":"3.5.0","structurizr":"3.0.0","bytefield":"1.11.0","wireviz":"0.3.3","excalidraw":"0.18.0","dbml":"1.0.30","packetdiag":"3.1.0","svgbob":"0.7.6","vega":"5.33.0","blockdiag":"3.1.0"},"status":"pass"}
```

## Kroki CLI
- https://github.com/yuzutech/kroki-cli
- https://docs.kroki.io/kroki/setup/kroki-cli/

kroki.yml
```yml
endpoint: 'http://localhost:8000'
timeout: 15s
```

Set the Environment Variables

```bash
set KROKI_ENDPOINT=http://localhost:8000
set KROKI_TIMEOUT=15s
```

## Kroki POST
HTTP Clients
- https://docs.kroki.io/kroki/setup/http-clients/

```bash
curl -X POST -H "Content-Type: text/plain" --data-binary "@tests/hello.dot" http://localhost:8000/graphviz/svg
```

```bash
curl http://localhost:8000/graphviz/svg --data-raw "digraph G {Hello->World}"
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

- https://www.html-code-generator.com/convert/image-svg-to-base64#images-to-base64

```html
<img src="data:image/png;base64,j4AAQS...">
```

```html
<img width="119px" height="155px" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPgo8IS0tIEdlbmVyYXRlZCBieSBncmFwaHZpeiB2ZXJzaW9uIDkuMC4wICgyMDIzMDkxMS4xODI3KQogLS0+CjwhLS0gVGl0bGU6IEcgUGFnZXM6IDEgLS0+Cjxzdmcgd2lkdGg9Ijg5cHQiIGhlaWdodD0iMTE2cHQiCiB2aWV3Qm94PSIwLjAwIDAuMDAgODkuMzcgMTE2LjAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIj4KPGcgaWQ9ImdyYXBoMCIgY2xhc3M9ImdyYXBoIiB0cmFuc2Zvcm09InNjYWxlKDEgMSkgcm90YXRlKDApIHRyYW5zbGF0ZSg0IDExMikiPgo8dGl0bGU+RzwvdGl0bGU+Cjxwb2x5Z29uIGZpbGw9IndoaXRlIiBzdHJva2U9Im5vbmUiIHBvaW50cz0iLTQsNCAtNCwtMTEyIDg1LjM3LC0xMTIgODUuMzcsNCAtNCw0Ii8+CjwhLS0gSGVsbG8gLS0+CjxnIGlkPSJub2RlMSIgY2xhc3M9Im5vZGUiPgo8dGl0bGU+SGVsbG88L3RpdGxlPgo8ZWxsaXBzZSBmaWxsPSJub25lIiBzdHJva2U9ImJsYWNrIiBjeD0iNDAuNjkiIGN5PSItOTAiIHJ4PSIzNy41MyIgcnk9IjE4Ii8+Cjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9IjQwLjY5IiB5PSItODUuMzMiIGZvbnQtZmFtaWx5PSJUaW1lcyxzZXJpZiIgZm9udC1zaXplPSIxNC4wMCI+SGVsbG88L3RleHQ+CjwvZz4KPCEtLSBXb3JsZCAtLT4KPGcgaWQ9Im5vZGUyIiBjbGFzcz0ibm9kZSI+Cjx0aXRsZT5Xb3JsZDwvdGl0bGU+CjxlbGxpcHNlIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIGN4PSI0MC42OSIgY3k9Ii0xOCIgcng9IjQwLjY5IiByeT0iMTgiLz4KPHRleHQgdGV4dC1hbmNob3I9Im1pZGRsZSIgeD0iNDAuNjkiIHk9Ii0xMy4zMiIgZm9udC1mYW1pbHk9IlRpbWVzLHNlcmlmIiBmb250LXNpemU9IjE0LjAwIj5Xb3JsZDwvdGV4dD4KPC9nPgo8IS0tIEhlbGxvJiM0NTsmZ3Q7V29ybGQgLS0+CjxnIGlkPSJlZGdlMSIgY2xhc3M9ImVkZ2UiPgo8dGl0bGU+SGVsbG8mIzQ1OyZndDtXb3JsZDwvdGl0bGU+CjxwYXRoIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIGQ9Ik00MC42OSwtNzEuN0M0MC42OSwtNjQuNDEgNDAuNjksLTU1LjczIDQwLjY5LC00Ny41NCIvPgo8cG9seWdvbiBmaWxsPSJibGFjayIgc3Ryb2tlPSJibGFjayIgcG9pbnRzPSI0NC4xOSwtNDcuNjIgNDAuNjksLTM3LjYyIDM3LjE5LC00Ny42MiA0NC4xOSwtNDcuNjIiLz4KPC9nPgo8L2c+Cjwvc3ZnPgo=">
```

## Moodle integration
- https://github.com/AdrianoRuseler/quiz2matlab