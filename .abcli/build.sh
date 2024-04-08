#! /usr/bin/env bash

function CV_build() {
    local options=$1

    if [ $(abcli_option_int "$options" help 0) == 1 ]; then
        local options="~commit,dryrun,~upload,what=<cv+cv-full>"
        abcli_show_usage "CV build$ABCUL[$options]$ABCUL[commit message]" \
            "build CV."
        return
    fi

    local do_dryrun=$(abcli_option_int "$options" dryrun 0)
    local do_commit=$(abcli_option_int "$options" commit $(abcli_not $do_dryrun))
    local do_upload=$(abcli_option_int "$options" upload $(abcli_not $do_dryrun))
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
        abcli_latex build dryrun=$do_dryrun \
            ./$filename.tex

        mv -v \
            $filename.pdf \
            ../pdf/$(echo $filename | sed 's/cv/arash-abadpour-resume/g').pdf
    done

    cd ..

    if [ "$do_commit" == 1 ]; then
        git add .
        git status

        local message="${@:2}"
        git commit -a -m "CV build $message"

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
}
