# Master Thesis
[![License](https://img.shields.io/github/license/jacquesd/master-thesis.svg)](https://github.com/jacquesd/master-thesis/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/jacquesd/master-thesis.svg?branch=master)](https://travis-ci.org/jacquesd/master-thesis)
[![PDF](https://img.shields.io/badge/PDF-latest-blue.svg?style=flat)](https://github.com/jacquesd/master-thesis/blob/master-pdf/JacquesDafflon-masterthesis.pdf)

This repository contains the report for the master thesis:



<p align="center" style="font-size:larger;">
<i>ERC777</i>
</p>
<p align="center" style="font-size:large;">
<i>A New Advanced Token Standard<br />
For The Ethereum Blockchain</i>
</p>

written by Jacques Dafflon, under the supervision of Prof. Cesare Pautasso (advisor)  and   Thomas Shababi (coadvisor), submitted to the Faculty of Informatics of the Università della Svizzera Italiana, Switzerland.


## License
This thesis is made available under the Creative Commons Public License, Attribution-ShareAlike 4.0
International. A copy of the full license is available in the [LICENSE](/LICENSE) file.

## PDF version
A rendered PDF version of the thesis is automatically generated using [travis-ci](https://travis-ci.org/jacquesd/master-thesis) and pushed back to this repository at [master-pdf:JacquesDafflon-masterthesis.pdf](https://github.com/jacquesd/master-thesis/blob/master-pdf/JacquesDafflon-masterthesis.pdf).

Generating the pdf locally requires pandoc (>=2.1.3), XeLaTeX, and Bibtex. Then, run:

``` bash
make
```

This will generate the report in pdf under the name ``JacquesDafflon-masterthesis.pdf` in the root folder.

To change the name or the generated pdf file, simply overwrite the `OUTPUT` variable (without the extension):

``` bash
make OUTPUT_FILE="new_file"
```

## Fast build
A "fast build" which only runs `pandoc` and `xelatex` once without `makeglossaries` or `bibtex` can be executed to quickly generate a PDF without references or glossary, with:

``` bash
make fast
```

> The `OUTPUT_FILE` variable can also be defined in this case.

## Template
The template used to generate the report is available at [template/template.tex](template/template.tex).

It has been adapted from the official [USI Informatics Master Thesis template](http://www.inf.usi.ch/msc-thesis-stylesheet-159301.zip). Note that this adaptation is only compatible for the master thesis and the PHD related elements of the template have been removed.

## Debug
The `tex` files and associated generated intermediary  files such as `.aux` are kept in the `BUILD` directory (default: `./build`) and can be inspect in case of issues when generating the PDF.

---
><a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This
work is licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative
Commons Attribution-ShareAlike 4.0 International License</a>.

<small><i>This README was generated automatically using the information in [`metadata.yml`](metadata.yml) via `make readme`.</i></small>
