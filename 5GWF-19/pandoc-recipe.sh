#!/bin/bash
pandoc --latex-engine=xelatex -t beamer front-matter.md general-framework.md design-rationales.md technical-specs.md perf-evaluation.md research-challenges.md back-matter.md -H ./generation-script/in_header.txt -o /Users/simurgh/Desktop/nbiot-tutorial-5gwf-19.pdf
#compilation can be partial
#pandoc --latex-engine=xelatex -t beamer perf-evaluation.md -H ./generation-script/in_header.txt -o /Users/simurgh/Desktop/nbiot-tutorial-5gwf-19.pdf
echo "magic is done!"
