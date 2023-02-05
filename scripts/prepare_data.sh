#!/bin/sh
python2.7 /home/repro/prepare_data.py > /home/repro/paper/tablefoursquare.tex
pdftex /home/repro/paper/report.tex paper