@echo off
cd /d "%~dp0"
latexmk -xelatex main.tex
exit /b %errorlevel%
