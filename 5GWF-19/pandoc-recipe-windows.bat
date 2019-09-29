@REM pandoc --latex-engine=xelatex -t beamer front-matter.md general-framework.md design-rationales.md technical-specs.md perf-evaluation.md research-challenges.md back-matter.md -H ./generation-script/in_header.txt -o nbiot-tutorial-5gwf-19.pdf

@REM compilation can be partial
@REM pandoc --latex-engine=xelatex -t beamer perf-evaluation.md -H ./generation-script/in_header.txt -o nbiot-tutorial-5gwf-19.pdf

pandoc --latex-engine=xelatex -t beamer front-matter.md general-framework.md design-rationales.md technical-specs.md link-perf-evaluation.md system-perf-evaluation.md back-matter.md -H ./generation-script/in_header.txt -o nbiot-tutorial-5gwf-19.pdf

echo "magic is done!"