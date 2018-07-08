#!/bin/bash
pandoc --pdf-engine=xelatex -f markdown+raw_tex -t beamer front-matter.md general-framework.md technical-specs.md perf-evaluation.md back-matter.md -H ./generation-script/in_header.txt -o /Users/simurgh/Desktop/lpwan-iot-tutorial-spects-18.pdf
#pandoc -s -t beamer -f markdown+raw_tex front-matter.md general-framework.md technical-specs.md perf-evaluation.md back-matter.md -H ./generation-script/in_header.txt -o /Users/simurgh/Desktop/lpwan-iot-tutorial.tex
echo "magic is done!"
