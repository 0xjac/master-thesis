$if(readme_title)$
# $readme_title$
$else$
# Master Thesis
$endif$
[![License](https://img.shields.io/github/license/$username$/$repo.name$.svg)](https://github.com/$username$/$repo.name$/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/jacquesd/master-thesis.svg?branch=master)](https://travis-ci.org/jacquesd/master-thesis)
[![PDF](https://img.shields.io/badge/PDF-latest-orange.svg?style=flat)](https://github.com/$username$/$repo.name$/blob/master-pdf/$generated_file$.pdf)

This repository contains the report for the master thesis:



<p align="center" style="font-size:larger;">
<i>$title$</i>
</p>

written by $author$, under the supervision of $advisor.title$ $advisor.name$ (advisor) $if(coadvisor)$ and  $coadvisor.title$ $coadvisor.name$ (coadvisor)$endif$, submitted to the $faculty$ of the $university$.


## License
This thesis is made available under the $license.name$. A copy of the full license is available in the [LICENSE](/LICENSE) file.

## PDF version
A rendered PDF version of the thesis is automatically generated using [travis-ci](https://travis-ci.org/jacquesd/master-thesis) and pushed back to this repository at [master-pdf:$generated_file$.pdf](https://github.com/$username$/$repo.name$/blob/master-pdf/$generated_file$.pdf).

Generating the pdf locally requires pandoc (>=2.1.3) and XeLaTeX, then run:

``` bash
make
```

This will generate the report in pdf under the name ``$generated_file$.pdf` in the root folder.

To change the name or the generated pdf file, simply overwrite the `OUTPUT` variable (without the extension):

``` bash
make OUTPUT="new_file"
```

## Template
The template used to generate the report is available at [template/template.tex](template/template.tex).

It has been adapted from the official [USI Informatics Master Thesis template](http://www.inf.usi.ch/msc-thesis-stylesheet-159301.zip). Note that this adaptation is only compatible for the master thesis and the PHD related elements of the template have been removed.

## Debug
If the PDF generation fails, the intermediary `tex` file can be generated instead with:

``` bash
make debug
```

This will generate the file `debug.tex` in the root folder which can be inspected and manualy compiled to pdf using `xetex`:

``` bash
xelatex debug.tex
```


---
$if(license.badge)$>$license.badge$$endif$
>
> This README was generated automatically using the information in [`metadata.yml`](metadata.yml) via `make readme`.
