import functools
from abcli import file
from CV import logger


def build():
    success, _revision_tex = file.load_text("_revision.tex")

    if success:
        current_revision = [
            float(item.split("\\space")[1])
            for item in _revision_tex
            if "revision" in item
        ]

        success = len(current_revision) == 1
        if not success:
            logger.info(f"{len(current_revision)} current revision(s) found.")

    if success:
        current_revision = current_revision[0]
        logger.info(f"current revision: {current_revision:.2f}")

        new_revision = current_revision + 0.01
        logger.info(f"new revision: {new_revision:.2f}")

        _revision_tex = [
            item.replace(f"{current_revision:.2f}", f"{new_revision:.2f}")
            for item in _revision_tex
            if item
        ]
        logger.info(f"_revision_tex: {'|'.join(_revision_tex)}")

        success = file.save_text("_revision.tex", _revision_tex)

    if success:
        success, _opening_statement = file.load_text("_opening_statement.tex")

    if success:
        abadpour_com_intro = [
            item
            for item in [
                functools.reduce(
                    lambda a, b: a.replace(b, " "),
                    [
                        "\\newcommand",
                        "\\osspacing",
                        "\\vspace{0.5cm}",
                        "\\vspace{0.8cm}",
                        "\\onehalfspace",
                        "\\textbf",
                        "\\singlespace",
                        "{ }",
                    ],
                    item.replace("\t", ""),
                )
                for item in _opening_statement
                if not item.startswith("%")
            ]
            if item
        ]

        abadpour_com_intro = [
            item.replace("\\href{", '<a href="')
            .replace("}{", '">')
            .replace("}", "</a>")
            for item in abadpour_com_intro
        ]

        success = file.save_text(
            "abadpour_com_intro.txt",
            [
                'My name is Arash and this is my story - more info in my <a href="https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume.pdf">resume</a>, <a href="https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume-full.pdf">resume + publications</a>, and <a href="https://www.linkedin.com/feed/">linkedin</a>.',
                "",
            ]
            + abadpour_com_intro,
        )

    return success
