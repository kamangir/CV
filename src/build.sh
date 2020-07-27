filename=cv

rm $filename.dvi
rm $filename.ps
rm $filename.pdf

"latex" -interaction=nonstopmode $filename.tex

"makeindex"$filename.idx

"dvips" -o $filename.ps $filename.dvi

"ps2pdf" $filename.ps

# ./ -bibtex
#cp /y cv.pdf ../

#bash ../../mypy/latex2pdf.sh cv-full.tex ./ -bibtex
#cp cv-full.pdf ../