
<!-- README.md is generated from README.Rmd. Please edit that file -->
scerden.aemetadb
================

``` r
library(scerden.aemetadb)
library(tidyverse)
#> Loading tidyverse: ggplot2
#> Loading tidyverse: tibble
#> Loading tidyverse: tidyr
#> Loading tidyverse: readr
#> Loading tidyverse: purrr
#> Loading tidyverse: dplyr
#> Conflicts with tidy packages ----------------------------------------------
#> filter(): dplyr, stats
#> lag():    dplyr, stats
```

R data pkg that makes avaiable two tables containing the subset of the [array express](http://www.ebi.ac.uk/arrayexpress/) data relevant to Saccharomyces cerevisiae:
1. `ae_arrays` contains information on experimental platforms

``` r
ae_arrays %>% glimpse()
#> Observations: 739
#> Variables: 3
#> $ accession <chr> "A-AFFY-27", "A-AFFY-42", "A-AFFY-47", "A-AFFY-116",...
#> $ name      <chr> "Affymetrix GeneChip Yeast Genome S98 [YG_S98]", "Af...
#> $ organism  <chr> "Saccharomyces cerevisiae", "Saccharomyces cerevisia...
```

1.  `ae_experiments` contains information on experiments

``` r
ae_experiments %>% glimpse()
#> Observations: 1,994
#> Variables: 11
#> $ accession        <chr> "E-MTAB-4826", "E-MTAB-4268", "E-GEOD-75263",...
#> $ title            <chr> "RIP-seq analysis of Isw1 interacting transcr...
#> $ type             <chr> "RIP-seq", "transcription profiling by array"...
#> $ organism         <chr> "Saccharomyces cerevisiae", "Saccharomyces ce...
#> $ assays           <int> 18, 12, 180, 81, 6, 18, 12, 63, 6, 6, 2, 16, ...
#> $ release_date     <date> 2016-11-17, 2016-09-25, 2016-09-01, 2016-09-...
#> $ processed_data   <chr> "Data is not available", "Data is not availab...
#> $ raw_data         <chr> "Data is not available", "http://www.ebi.ac.u...
#> $ present_in_atlas <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
#> $ arrayexpress_url <chr> "http://www.ebi.ac.uk/arrayexpress/experiment...
#> $ array            <chr> NA, "A-AFFY-116", "A-GEOD-4414,A-MEXP-1113", ...
```

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
use_data()
```

-   see `data-raw/` in pkg source:

| step | description                                    |
|:-----|:-----------------------------------------------|
| 01   | download ae arrays metadata                    |
| 02   | clean tbl for valid arrays                     |
| 03   | remove intermediates                           |
| 04   | download and save ae experiments scer metadata |
| 05   | ae experiment to ae array mapping              |

-   when writing `R/` fxns:

``` r
use_package("tidyr")
use_package("dplyr")
use_package("purrr")
use_package("stringr")
```
