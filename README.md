
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

1.  `ae_cel_files`

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
| 02   | clean tbl for valid arrays and save            |
| 03   | remove intermediates                           |
| 04   | download and save ae experiments scer metadata |
| 05   | download all sdrf files                        |
| 06   | ae experiment associated cel files             |

-   when writing `R/` fxns:

``` r
use_package("tidyr")
use_package("dplyr")
use_package("purrr")
use_package("stringr")
```
