#!/bin/bash
#pandoc --latex-engine=xelatex -t beamer front-matter.md general-framework.md design-rationales.md technical-specs.md perf-evaluation.md research-challenges.md -H ./generation-script/in_header.txt -o lpwan-iot-tutorial-ict-18.pdf
#compilation can be partial
pandoc --latex-engine=xelatex -t beamer front-matter.md general-framework.md -H ./generation-script/in_header.txt -o lpwan-iot-tutorial-ict-18.pdf
echo "magic is done!"
