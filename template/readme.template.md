$if(readme_title)$
# $readme_title$
$else$
# Master Thesis
$endif$
[![License](https://img.shields.io/github/license/$username$/$repo.name$.svg)](https://github.com/$username$/$repo.name$/blob/master/LICENSE)

This repository contains the report for the master thesis:



<p align="center" style="font-size:larger;">
<i>$title$</i>
</p>

written by $author$, under the supervision of $advisor.title$ $advisor.name$ (advisor) $if(coadvisor)$ and  $coadvisor.title$ $coadvisor.name$ (coadvisor)$endif$, submitted to the $faculty$ of the $university$.


# License
This thesis is made available under the $license.name$. A copy of the full license is available in the [LICENSE](/LICENSE) file.

## Generating the PDF version
A rendered PDF version of the thesis should be included with this repository:
[$generated_file$.pdf](/$generated_file$.pdf)



---
$if(license.badge)$$license.badge$$endif$
