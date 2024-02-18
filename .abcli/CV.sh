#! /usr/bin/env bash

function CV() {
    abcli_CV $@
}

function abcli_CV() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        local options="~commit,~upload,what=<cv+cv-full>"
        abcli_show_usage "CV build$ABCUL[$options]$ABCUL[commit message]" \
            "build CV."
        abcli_show_usage "CV clean" \
            "clean CV."

        if [ "$(abcli_keyword_is $2 verbose)" == true ]; then
            python3 -m CV --help
        fi
        return
    fi

    if [ "$task" == "build" ]; then
        local options=$2
        local do_commit=$(abcli_option_int "$options" commit 1)
        local do_upload=$(abcli_option_int "$options" upload 1)
        local what=$(abcli_option "$options" what cv+cv-full)

        abcli_log "building CV... [$what]"

        pushd $abcli_path_git/CV >/dev/null

        pip3 install -e .

        cd src

        python3 -m CV build

        git add _revision.tex

        rm -rfv ../pdf
        mkdir -p ../pdf

        local filename
        for filename in $(echo $what | tr + " "); do
            abcli_log "building $filename..."
            rm $filename.dvi
            rm $filename.ps

            "latex" -interaction=nonstopmode $filename.tex >>$filename.latex.log

            "makeindex" $filename.idx >>$filename.makeindex.log

            "dvips" -o $filename.ps $filename.dvi >>$filename.dvips.log

            "ps2pdf" $filename.ps >>$filename.ps2pdf.log

            mv -v \
                $filename.pdf \
                ../pdf/$(echo $filename | sed 's/cv/arash-abadpour-resume/g').pdf
        done

        cd ..

        if [ "$do_commit" == 1 ]; then
            git add .
            git status

            local message="${@:2}"
            git commit -a -m "abcli build $message"

            git push
        fi

        if [ "$do_upload" == 1 ]; then
            cd pdf
            local filename
            for filename in *.pdf; do
                aws s3 cp $filename s3://abadpour-com/cv/$filename
            done
        fi

        popd >/dev/null
        return
    fi

    if [ "$task" == "clean" ]; then
        pushd $abcli_path_git/CV/src >/dev/null
        rm *.aux
        rm *.dvi
        rm *.log
        rm *.out
        rm *.ps
        popd >/dev/null
        return
    fi

    abcli_log_error "-CV: $task: command not found."
}
