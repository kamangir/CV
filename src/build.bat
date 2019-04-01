call ..\..\mypy\latex2pdf cv.tex %cd%\ -bibtex
move cv.pdf ../

call ..\..\mypy\latex2pdf cv-full.tex %cd%\ -bibtex
move cv-full.pdf ../