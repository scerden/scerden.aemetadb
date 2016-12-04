
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
#> Observations: 735
#> Variables: 3
#> $ accession <chr> "A-AFFY-27", "A-AFFY-42", "A-AFFY-47", "A-AFFY-116",...
#> $ name      <chr> "Affymetrix GeneChip Yeast Genome S98 [YG_S98]", "Af...
#> $ organism  <chr> "Saccharomyces cerevisiae", "Saccharomyces cerevisia...
```

1.  `ae_experiments` contains information on experiments

``` r
ae_experiments %>% glimpse()
#> Observations: 1,566
#> Variables: 10
#> $ ae_experiment    <chr> "E-GEOD-77842", "E-GEOD-69485", "E-GEOD-65942...
#> $ title            <chr> "Physiology of S. cerevisiae during aerobic c...
#> $ type             <chr> "transcription profiling by array", "transcri...
#> $ organism         <chr> "Saccharomyces cerevisiae", "Saccharomyces ce...
#> $ assays           <int> 13, 20, 16, 7, 8, 17, 4, 6, 11, 12, 210, 27, ...
#> $ release_date     <date> 2016-06-01, 2016-01-01, 2015-12-22, 2015-04-...
#> $ processed_data   <chr> "https://www.ebi.ac.uk/arrayexpress/files/E-G...
#> $ raw_data         <chr> "https://www.ebi.ac.uk/arrayexpress/files/E-G...
#> $ present_in_atlas <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
#> $ arrayexpress_url <chr> "https://www.ebi.ac.uk/arrayexpress/experimen...
```

1.  `ae_links` contains links between accession type within AE

``` r
ae_links
#> # A tibble: 1,849 × 2
#>     ae_array ae_experiment
#>        <chr>         <chr>
#> 1  A-AFFY-27  E-GEOD-77842
#> 2  A-AFFY-27  E-GEOD-69485
#> 3  A-AFFY-27  E-GEOD-65942
#> 4  A-AFFY-27  E-GEOD-43474
#> 5  A-AFFY-27  E-GEOD-65111
#> 6  A-AFFY-27  E-GEOD-55372
#> 7  A-AFFY-27  E-GEOD-52256
#> 8  A-AFFY-27  E-GEOD-17527
#> 9  A-AFFY-27  E-GEOD-46853
#> 10 A-AFFY-27  E-GEOD-49002
#> # ... with 1,839 more rows
```

1.  `ae_cel_files` cel file names made by parsing all he SDRF.txt files for scerden AE experiments

``` r
ae_cel_files
#> # A tibble: 564 × 2
#>    ae_experiment  cel_files
#>            <chr>     <list>
#> 1   E-GEOD-10031 <chr [22]>
#> 2   E-GEOD-10066  <chr [9]>
#> 3   E-GEOD-10073  <chr [6]>
#> 4   E-GEOD-10091  <chr [4]>
#> 5   E-GEOD-10104  <chr [6]>
#> 6   E-GEOD-10205 <chr [14]>
#> 7   E-GEOD-10521 <chr [25]>
#> 8   E-GEOD-10554  <chr [6]>
#> 9   E-GEOD-10930  <chr [4]>
#> 10  E-GEOD-10933  <chr [4]>
#> # ... with 554 more rows
```

1.  `ae_samples` contains names and urls of sample data files for experiments in AE scerden

``` r
ae_samples
#> # A tibble: 96,434 × 5
#>    ae_experiment assay_name         type
#>            <chr>      <chr>        <chr>
#> 1   E-GEOD-77842 GSM2060303         data
#> 2   E-GEOD-77842 GSM2060303 derived data
#> 3   E-GEOD-77842 GSM2060302         data
#> 4   E-GEOD-77842 GSM2060302 derived data
#> 5   E-GEOD-77842 GSM2060301         data
#> 6   E-GEOD-77842 GSM2060301 derived data
#> 7   E-GEOD-77842 GSM2060300         data
#> 8   E-GEOD-77842 GSM2060300 derived data
#> 9   E-GEOD-77842 GSM2060299         data
#> 10  E-GEOD-77842 GSM2060299 derived data
#> # ... with 96,424 more rows, and 2 more variables: name <chr>, url <chr>
```

In principle this should be a superset of array express only data and the GEO/SRA databases over at NCBI but this is not the case in practise.

install
-------

``` r
devtools::install_github("scerden/scerden.aemetadb")
```

pkg API
-------

Get sample files associated with an experiment:

``` r
ae_sample_files("E-MEXP-27")
#> # A tibble: 40 × 4
#>          assay_name                type
#>               <chr>               <chr>
#> 1  E-MEXP-27:xrn1-B                data
#> 2  E-MEXP-27:xrn1-B derived data matrix
#> 3        xrn1upf3-A                data
#> 4        xrn1upf3-A derived data matrix
#> 5        xrn1nmd2-D                data
#> 6        xrn1nmd2-D derived data matrix
#> 7  E-MEXP-27:xrn1-D                data
#> 8  E-MEXP-27:xrn1-D derived data matrix
#> 9            xrn1-C                data
#> 10           xrn1-C derived data matrix
#> # ... with 30 more rows, and 2 more variables: name <chr>, url <chr>
```

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
| 02   | clean tbl for valid arrays and save            |
| 03   | remove intermediates                           |
| 04   | download and save ae experiments scer metadata |
| 05   | download all sdrf files                        |
| 06   | ae experiment associated cel files             |
| 06   | b download sample files and parse              |

-   when writing `R/` fxns:

``` r
use_package("tidyr")
use_package("dplyr")
use_package("purrr")
use_package("stringr")
use_package("httr")
use_package("tibble")
```
