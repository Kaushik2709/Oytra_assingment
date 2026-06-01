#!/bin/bash
# Script to convert Task 1 QA Report from Markdown to PDF

# Check if md-to-pdf is installed
if command -v npx &> /dev/null
then
    echo "Using npx md-to-pdf for conversion..."
    npx md-to-pdf ../Task1_QA_Report.md
else
    echo "npx not found. Falling back to pandoc if available..."
    if command -v pandoc &> /dev/null
    then
        pandoc ../Task1_QA_Report.md -o ../Task1_QA_Report.pdf
    else
        echo "Error: Neither md-to-pdf (via npx) nor pandoc is installed."
        exit 1
    fi
fi

echo "Conversion complete: Task1_QA_Report.pdf"
