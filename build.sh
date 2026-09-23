#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
exec latexmk -xelatex main.tex
