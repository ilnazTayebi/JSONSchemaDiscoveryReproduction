#!/bin/sh

python2.7 /home/repro/prepare_data.py > /home/repro/paper/tablefoursquare.tex
pdflatex /home/repro/paper/report.tex
