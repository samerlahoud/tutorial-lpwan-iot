#!/bin/bash
pandoc --pdf-engine=xelatex -f markdown+raw_tex -t beamer front-matter.md general-framework.md design-rationales.md technical-specs.md perf-evaluation.md research-challenges.md back-matter.md -H ./generation-script/in_header.txt -o nbiot-tutorial-5gwf-19.pdf
#compilation can be partial
#pandoc --pdf-engine=xelatex -f markdown+raw_tex -t beamer front-matter.md general-framework.md -H ./generation-script/in_header.txt -o nbiot-tutorial-5gwf-19.pdf
echo "magic is done!"
