#! /usr/bin/env bash

function CV() {
    abcli_CV $@
}

function abcli_CV() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "CV build [cv/cv-full] [commit message]" \
            "build CV [and commit w/ message]."
        abcli_help_line "CV clean" \
            "clean CV."
        abcli_help_line "CV terraform" \
            "terraform CV."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m CV --help
        fi
        return
    fi

    if [ "$task" == "build" ] ; then
        local what="$2"

        abcli_log "building CV... $what"

        pushd $abcli_path_git/CV/src > /dev/null

        python3 -m CV build

        git add _revision.tex

        rm ../pdf/*.pdf

        local filename
        for filename in cv cv-full; do
            if [ -z "$what" ] || [ "$what" = "$filename" ]; then
                abcli_log "building $filename..."
                rm $filename.dvi
                rm $filename.ps

                "latex" -interaction=nonstopmode $filename.tex >> $filename.latex.log

                "makeindex" $filename.idx >> $filename.makeindex.log

                "dvips" -o $filename.ps $filename.dvi >> $filename.dvips.log

                "ps2pdf" $filename.ps >> $filename.ps2pdf.log

                mv $filename.pdf ../pdf/
            fi
        done

        cd ..

        mv pdf/cv.pdf pdf/arash-abadpour-resume.pdf
        mv pdf/cv-full.pdf pdf/arash-abadpour-resume-full.pdf

        git add .

        git status

        local message="${@:2}" 
        git commit -a -m "abcli build $message"

        git push

        cd pdf
        local filename
        for filename in *.pdf; do
            aws s3 cp $filename s3://abadpour-com/cv/$filename
        done

        popd  > /dev/null
        return
    fi

    if [ "$task" == "clean" ] ; then
        pushd $abcli_path_git/CV/src > /dev/null
        rm *.aux
        rm *.dvi
        rm *.log
        rm *.out
        rm *.ps
        popd > /dev/null
        return
    fi

    if [ "$task" == "terraform" ] ; then
        abcli_git terraform CV
        return
    fi

    abcli_log_error "-CV: $task: command not found."
}