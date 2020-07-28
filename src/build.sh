if [ -z "$1" ]; then
    echo "./build.sh #xyz [cv/cv-full/kamangir-resume]"
    exit 1
fi

for filename in cv cv-full kamangir-resume; do
    if [ -z "$2" ] || [ "$2" = "$filename" ]; then
        echo "=== $filename =========="
        rm $filename.dvi
        rm $filename.ps
        rm $filename.pdf

        "latex" -interaction=nonstopmode $filename.tex

        "makeindex"$filename.idx

        "dvips" -o $filename.ps $filename.dvi

        "ps2pdf" $filename.ps

        mv $filename.pdf ../

        git add ../$filename.pdf
    fi
done

git status

git commit -a -m "$1"; git push

pushd ..
ls -la *.pdf
popd