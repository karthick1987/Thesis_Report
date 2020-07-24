#!/bin/sh

if [ "$#" -gt 2 ]; then
    echo "Usage: ./compile.sh <FILENAME>"
    exit -1;
fi

if [ "$#" -eq 0 ]; then
    FILE=finalReport
fi

if [ "$#" -eq 1 ]; then
    FILE="$1"
fi
FILEWITHTEX=${FILE}".tex"
PDFLATEXFLAGS="-halt-on-error"

echo "Compiling the $FILEWITHTEX using PDFlatex"

runBibTex="bibtex ${FILE}"
runGlos="makeglossaries ${FILE}"
runpdfLatex="pdflatex ${PDFLATEXFLAGS} ${FILEWITHTEX}"

outputBib=$(eval ${runBibTex})
outputGlos=$(eval ${runGlos})
outputPdf=$(eval ${runpdfLatex})

testError=$(echo $outputPdf | grep -ci "error") #>/dev/null
#echo "$testError"
#runtestError=$(eval ${testError})

if [ $testError -gt 0 ]; then
    echo "PDF Generation Failed"
else
    echo "PDF Generation Success"
fi
