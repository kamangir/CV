if [ -z "$1" ]; then
    echo "./build.sh #xyz [cv/cv-full/kamangir-resume]"
    exit 1
fi

python build.py

rm ../*.pdf

for filename in cv cv-full kamangir-resume; do
    if [ -z "$2" ] || [ "$2" = "$filename" ]; then
        echo "=== $filename =========="
        rm $filename.dvi
        rm $filename.ps
        rm $filename.pdf

        "latex" -interaction=nonstopmode $filename.tex >> $filename.latex.log

        "makeindex"$filename.idx >> $filename.makeindex.log

        "dvips" -o $filename.ps $filename.dvi >> $filename.dvips.log

        "ps2pdf" $filename.ps >> $filename.ps2pdf.log

        mv $filename.pdf ../

        git add ../$filename.pdf
    fi
done

git status

git commit -a -m "$1"; git push

pushd ..
cp cv.pdf Arash-Abadpour-Resume.pdf
cp cv-full.pdf Arash-Abadpour-Resume-Full-Version.pdf
ls -la *.pdf
popd