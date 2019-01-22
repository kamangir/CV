@echo off

rem Revision 1.01

call ..\..\Dec8\src\mypy\latex2pdf cv.tex %cd%\ -bibtex

call ..\..\Dec8\src\mypy\latex2pdf cv-full.tex %cd%\ -bibtex