import sys

sys.path.append("../../mypy")
import File
import String

success, _revision_tex = File.load_text("_revision.tex")
if success:
    current_revision = [float(string.split("\\space")[1]) for string in _revision_tex if "revision" in string]
    success = len(current_revision) == 1
    if not success:
        print(f"{len(current_revision)} current revision(s).")
        exit

if success:
    print(f"current revision: {current_revision[0]:.2f}")

    new_revision = current_revision[0] + 0.01
    print(f"new revision: {new_revision:.2f}")

    _revision_tex = [
        string.replace(f"{current_revision[0]:.2f}", f"{new_revision:.2f}") for string in _revision_tex if string
    ]
    print(f"_revision_tex: {'|'.join(_revision_tex)}")

    success = File.save_text("_revision.tex", _revision_tex)

print("failure,success".split(",")[int(success)])

