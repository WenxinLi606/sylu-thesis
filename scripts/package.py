#!/usr/bin/env python3
"""Export an explicit source allowlist; never include local fonts or caches."""
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED

ROOT = Path(__file__).resolve().parents[1]
FILES = [
    'main.tex', 'thesis-info.tex', 'syluthesis.cls', 'sylu-fonts.tex',
    'cover-word.tex', 'gbt7714-2005-numerical.bst', 'latexmkrc',
    'build.sh', 'build.cmd', 'README.md', 'THIRD_PARTY.md', 'license.txt',
    '.gitignore', 'fonts/README.md', 'docs/USAGE.md', 'docs/VALIDATION.md', 'docs/RELEASE_NOTES.md',
    'scripts/package.py', 'reference/references.bib', 'figures/workflow.tex',
    'chapters/abstract.tex',
    'chapters/chapter1.tex', 'chapters/chapter2.tex',
    'chapters/chapter3.tex', 'chapters/chapter4.tex',
    'chapters/appendix.tex', 'chapters/acknowledgement.tex', 'chapters/resume.tex',
]

def main():
    for name in FILES:
        if not (ROOT / name).is_file():
            raise SystemExit('Required source file missing: ' + name)
    output = ROOT / 'dist' / 'syluthesis-template.zip'
    output.parent.mkdir(exist_ok=True)
    with ZipFile(output, 'w', ZIP_DEFLATED) as archive:
        for name in FILES:
            archive.write(ROOT / name, name)
    print(output)

if __name__ == '__main__':
    main()
