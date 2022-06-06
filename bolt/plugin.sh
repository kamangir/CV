#! /usr/bin/env bash

function bolt_CV() {
    local task=$(bolt_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        bolt_help_line "CV build [cv/cv-full] [commit message]" \
            "build CV [and commit w/ message]."
        bolt_help_line "CV clean" \
            "clean CV."
        bolt_help_line "CV terraform" \
            "terraform CV."


        if [ "$(bolt_keyword_is $2 verbose)" == true ] ; then
            python3 -m CV --help
        fi
        return
    fi

    if [ "$task" == "build" ] ; then
        local what="$2"

        bolt_log "building CV... $what"

        pushd $bolt_path_git/CV/src > /dev/null

        python3 -m CV

        git add _revision.tex

        rm ../*.pdf

        local filename
        for filename in cv cv-full; do
            if [ -z "$what" ] || [ "$what" = "$filename" ]; then
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
        popd > /dev/null

        pushd $bolt_path_git/CV > /dev/null

        mv cv.pdf arash-abadpour-resume.pdf
        mv cv-full.pdf arash-abadpour-resume-full.pdf

        git add *.pdf

        git status

        local message="${@:2}"
        git commit -a -m "$1"

        git push

        local filename
        for filename in *.pdf; do
            aws s3 cp $filename s3://abadpour-com/cv/$filename
        done

        popd  > /dev/null
        return
    fi

    if [ "$task" == "clean" ] ; then
        pushd $bolt_path_git/CV/src > /dev/null
        rm *.aux
        rm *.dvi
        rm *.log
        rm *.out
        rm *.ps
        popd > /dev/null
        return
    fi

    if [ "$task" == "terraform" ] ; then
        bolt_git terraform CV
        return
    fi

    bolt_error "unknown task: CV '$task'."
}