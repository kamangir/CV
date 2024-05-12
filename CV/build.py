import functools
from abcli import file
from CV import VERSION


def build() -> bool:
    if not file.save_text(
        "_revision.tex",
        ["\\vspace{0.5cm}revision\space" + VERSION + "\space-\space\\today"],
    ):
        return False

    success, _opening_statement = file.load_text("_opening_statement.tex")
    if not success:
        return False

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
        item.replace("\\href{", '<a href="').replace("}{", '">').replace("}", "</a>")
        for item in abadpour_com_intro
    ]

    return file.save_text(
        "abadpour_com_intro.txt",
        [
            'My name is Arash and this is my story - more info in my <a href="https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume.pdf">resume</a>, <a href="https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume-full.pdf">resume + publications</a>, and <a href="https://www.linkedin.com/feed/">linkedin</a>.',
            "",
        ]
        + abadpour_com_intro,
    )
