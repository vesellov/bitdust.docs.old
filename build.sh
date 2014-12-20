#!/bin/bash



python md2html.py "$1" > "$1.html"
python fix_html.py "$1.html" "$1.html" styles.css    




