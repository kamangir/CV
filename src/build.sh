for filename in cv cv-full kamangir-resume; do
    if [ -z "$1" ] || [ "$1" = "$filename" ]; then
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

git commit -a -m "cv rebuilt"; git push

pushd ..
ls -la *.pdf
popd