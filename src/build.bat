call ..\..\mypy\latex2pdf cv.tex %cd%\ -bibtex
copy /y cv.pdf ..\

call ..\..\mypy\latex2pdf cv-full.tex %cd%\ -bibtex
copy /y cv-full.pdf ..\