
<!-- README.md is generated from README.Rmd. Please edit that file -->
scerden.aemetadb
================

R data pkg that makes avaiable two tables containing the subset of the [array express](http://www.ebi.ac.uk/arrayexpress/) data relevant to Saccharomyces cerevisiae:
1. `ae_arrays` contains information on experimental platforms
2. `ae_experiments` contains information on experiments

In principle this should be a superset of array express only data and the GEO/SRA databases over at NCBI but this is not the case in practise.

install
-------

``` r
devtools::install_github("scerden/scerden.aemetadb")
```

pkg API
-------

No exported functions at this time.

pkg creation:
-------------

-   Prelims

``` r
use_readme_rmd()
use_data_raw()
```

-   see `data-raw/` in pkg source:

| step | description                                    |
|:-----|:-----------------------------------------------|
| 01   | download ae arrays metadata                    |
| 02   | clean tbl for valid arrays                     |
| 03   | remove intermediates                           |
| 04   | download and save ae experiments scer metadata |

-   when writing `R/` fxns:

``` r
use_package("tidyr")
use_package("dplyr")
use_package("purrr")
use_package("stringr")
```
