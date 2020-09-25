import functools
import sys

sys.path.append("../../mypy")
import File
import utils.string


success, _revision_tex = File.load_text("_revision.tex")

if success:
    current_revision = [
        float(string.split("\\space")[1])
        for string in _revision_tex
        if "revision" in string
    ]

    success = len(current_revision) == 1
    if not success:
        print(f"{len(current_revision)} current revision(s).")

if success:
    current_revision = current_revision[0]
    print(f"current revision: {current_revision:.2f}")

    new_revision = current_revision + 0.01
    print(f"new revision: {new_revision:.2f}")

    _revision_tex = [
        string.replace(f"{current_revision:.2f}", f"{new_revision:.2f}")
        for string in _revision_tex
        if string
    ]
    print(f"_revision_tex: {'|'.join(_revision_tex)}")

    success = File.save_text("_revision.tex", _revision_tex)

if success:
    success, _opening_statement = File.load_text("_opening_statement.tex")

if success:
    abadpour_com_intro = [
        string
        for string in [
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
                string.replace("\t", ""),
            )
            for string in _opening_statement
            if (not string.startswith("%")) and ("\\large" not in string)
        ]
        if string
    ]

    abadpour_com_intro = [
        string.replace("\\url{", '<a href="').replace("}{", '">').replace("}", "</a>")
        for string in abadpour_com_intro
    ]

    success = File.save_text(
        "abadpour_com_intro.txt",
        [
            'My name is Arash Abadpour and this is my story (<a href="https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume.pdf">resume</a>, <a href="https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume-full.pdf">resume + publications</a>, <a href="https://www.linkedin.com/feed/">linkedin</a>):',
            "",
        ]
        + abadpour_com_intro
        + ["", f"-- last updated: {utils.string.pretty_date('~time')}"],
    )

print("failure,success".split(",")[int(success)])

