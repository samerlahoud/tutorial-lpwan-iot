#!/bin/bash
pandoc --latex-engine=xelatex -t beamer front-matter.md general-framework.md design-rationales.md technical-specs.md perf-evaluation.md experimentation.md -H ./generation-script/in_header.txt -o lpwan-iot-tutorial-esib-18.pdf
#compilation can be partial
#pandoc --latex-engine=xelatex -t beamer front-matter.md perf-evaluation.md -H ./generation-script/in_header.txt -o lpwan-iot-tutorial-esib-18.pdf
echo "magic is done!"
