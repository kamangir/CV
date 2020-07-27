for filename in cv cv_full; do
    rm $filename.dvi
    rm $filename.ps
    rm $filename.pdf

    "latex" -interaction=nonstopmode $filename.tex

    "makeindex"$filename.idx

    "dvips" -o $filename.ps $filename.dvi

    "ps2pdf" $filename.ps

    mv $filename.pdf ../
end