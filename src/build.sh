if [ -z "$1" ]; then
    echo "./build.sh #xyz [cv/cv-full]"
    exit 1
fi

python build.py
git add _revision.tex

rm ../*.pdf

for filename in cv cv-full; do
    if [ -z "$2" ] || [ "$2" = "$filename" ]; then
        echo "=== $filename =========="
        rm $filename.dvi
        rm $filename.ps

        "latex" -interaction=nonstopmode $filename.tex >> $filename.latex.log

        "makeindex"$filename.idx >> $filename.makeindex.log

        "dvips" -o $filename.ps $filename.dvi >> $filename.dvips.log

        "ps2pdf" $filename.ps >> $filename.ps2pdf.log

        mv $filename.pdf ../
    fi
done

pushd ..
mv cv.pdf arash-abadpour-resume.pdf
mv cv-full.pdf arash-abadpour-resume-full.pdf

git add *.pdf

git status

git commit -a -m "$1"; git push
popd

#python upload.py
