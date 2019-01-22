@echo off

rem Revision 1.02

call ..\..\Dec8\src\mypy\latex2pdf cv.tex %cd%\ -bibtex
move cv.pdf ../

call ..\..\Dec8\src\mypy\latex2pdf cv-full.tex %cd%\ -bibtex
move cv-full.pdf ../