#!/bin/bash
pandoc --latex-engine=xelatex -t beamer $1.md -H ./generation-script/in_header.txt -o $1.pdf
echo "magic is done!"
