# Master Thesis
[![License](https://img.shields.io/github/license/jacquesd/master-thesis.svg)](https://github.com/jacquesd/master-thesis/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/jacquesd/master-thesis.svg?branch=master)](https://travis-ci.org/jacquesd/master-thesis)
[![PDF](https://img.shields.io/badge/PDF-latest-blue.svg?style=flat)](https://github.com/jacquesd/master-thesis/blob/master-pdf/JacquesDafflon-masterthesis.pdf)

This repository contains the report for the master thesis:



<p align="center" style="font-size:larger;">
<i>ERC777 the new token standard,<br />
and trust-less payment channel<br />
tokenized loyalty points</i>
</p>

written by Jacques Dafflon, under the supervision of Prof. Cesare Pautasso (advisor)  and  Mr. Thomas Shababi (coadvisor), submitted to the Faculty of Informatics of the Università della Svizzera Italiana, Switzerland.


## License
This thesis is made available under the Creative Commons Public License, Attribution-ShareAlike 4.0
International. A copy of the full license is available in the [LICENSE](/LICENSE) file.

## PDF version
A rendered PDF version of the thesis is automatically generated using [travis-ci](https://travis-ci.org/jacquesd/master-thesis) and pushed back to this repository at [master-pdf:JacquesDafflon-masterthesis.pdf](https://github.com/jacquesd/master-thesis/blob/master-pdf/JacquesDafflon-masterthesis.pdf).

Generating the pdf locally requires pandoc (>=2.1.3) and XeLaTeX, then run:

``` bash
make
```

This will generate the report in pdf under the name ``JacquesDafflon-masterthesis.pdf` in the root folder.

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
><a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This
work is licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative
Commons Attribution-ShareAlike 4.0 International License</a>.
>
> This README was generated automatically using the information in [`metadata.yml`](metadata.yml) via `make readme`.
