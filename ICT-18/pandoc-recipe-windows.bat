@REM pandoc --latex-engine=xelatex -t beamer front-matter.md general-framework.md design-rationales.md technical-specs.md perf-evaluation.md research-challenges.md back-matter.md -H ./generation-script/in_header.txt -o lpwan-iot-tutorial-ict-18.pdf

@REM compilation can be partial
pandoc --latex-engine=xelatex -t beamer perf-evaluation.md -H ./generation-script/in_header.txt -o lpwan-iot-tutorial-ict-18.pdf

echo "magic is done!"
