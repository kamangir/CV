filename=cv

rm $filename.dvi
rm $filename.ps
rm $filename.pdf

"latex" -interaction=nonstopmode $filename.tex

# ./ -bibtex
#cp /y cv.pdf ../

#bash ../../mypy/latex2pdf.sh cv-full.tex ./ -bibtex
#cp cv-full.pdf ../