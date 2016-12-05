
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

### Array Express REST API

#### main exported functions:

-   `ae_get_files(accession)`
-   `ae_get_samples(accession)`
-   `ae_get_platforms(accession)`

Starting from an experiment accession:

``` r
x <- "E-MEXP-27"
```

get associated files:

``` r
ae_get_files(x)
#> # A tibble: 1 × 2
#>   accession            files
#>       <chr>           <list>
#> 1 E-MEXP-27 <tibble [6 × 7]>
ae_get_files(x) %>% unnest()
#> # A tibble: 6 × 8
#>   accession                  location                      name extension
#>       <chr>                     <chr>                     <chr>     <chr>
#> 1 E-MEXP-27         E-MEXP-27.idf.txt         E-MEXP-27.idf.txt       txt
#> 2 E-MEXP-27 E-MEXP-27.processed.1.zip E-MEXP-27.processed.1.zip       zip
#> 3 E-MEXP-27       E-MEXP-27.raw.1.zip       E-MEXP-27.raw.1.zip       zip
#> 4 E-MEXP-27        E-MEXP-27.sdrf.txt        E-MEXP-27.sdrf.txt       txt
#> 5 E-MEXP-27         A-AFFY-27.adf.txt         A-AFFY-27.adf.txt       txt
#> 6 E-MEXP-27         A-AFFY-27.adf.xls         A-AFFY-27.adf.xls       xls
#> # ... with 4 more variables: kind <chr>, size <int>, lastmodified <chr>,
#> #   url <chr>
```

get associated samples:

``` r
ae_get_samples(x)
#> # A tibble: 1 × 2
#>   accession           samples
#>       <chr>            <list>
#> 1 E-MEXP-27 <tibble [20 × 5]>
ae_get_samples(x) %>% unnest()
#> # A tibble: 20 × 6
#>    accession       assay_name  characteristics            files  scan_name
#>        <chr>            <chr>           <list>           <list>      <chr>
#> 1  E-MEXP-27 E-MEXP-27:xrn1-B <tibble [5 × 1]> <tibble [2 × 3]>     xrn1-B
#> 2  E-MEXP-27       xrn1upf3-A <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf3-A
#> 3  E-MEXP-27       xrn1nmd2-D <tibble [5 × 1]> <tibble [2 × 3]> xrn1nmd2-D
#> 4  E-MEXP-27 E-MEXP-27:xrn1-D <tibble [5 × 1]> <tibble [2 × 3]>     xrn1-D
#> 5  E-MEXP-27           xrn1-C <tibble [5 × 1]> <tibble [2 × 3]>     xrn1-C
#> 6  E-MEXP-27       xrn1nmd2-C <tibble [5 × 1]> <tibble [2 × 3]> xrn1nmd2-C
#> 7  E-MEXP-27   E-MEXP-27:WT-D <tibble [5 × 1]> <tibble [2 × 3]>       WT-D
#> 8  E-MEXP-27       xrn1upf3-B <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf3-B
#> 9  E-MEXP-27       xrn1upf1-A <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf1-A
#> 10 E-MEXP-27       xrn1upf1-B <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf1-B
#> 11 E-MEXP-27       xrn1upf1-D <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf1-D
#> 12 E-MEXP-27   E-MEXP-27:WT-C <tibble [5 × 1]> <tibble [2 × 3]>       WT-C
#> 13 E-MEXP-27       xrn1upf3-D <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf3-D
#> 14 E-MEXP-27   E-MEXP-27:WT-A <tibble [5 × 1]> <tibble [2 × 3]>       WT-A
#> 15 E-MEXP-27   E-MEXP-27:WT-B <tibble [5 × 1]> <tibble [2 × 3]>       WT-B
#> 16 E-MEXP-27       xrn1upf3-C <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf3-C
#> 17 E-MEXP-27 E-MEXP-27:xrn1-A <tibble [5 × 1]> <tibble [2 × 3]>     xrn1-A
#> 18 E-MEXP-27       xrn1upf1-C <tibble [5 × 1]> <tibble [2 × 3]> xrn1upf1-C
#> 19 E-MEXP-27       xrn1nmd2-A <tibble [5 × 1]> <tibble [2 × 3]> xrn1nmd2-A
#> 20 E-MEXP-27       xrn1nmd2-B <tibble [5 × 1]> <tibble [2 × 3]> xrn1nmd2-B
#> # ... with 1 more variables: source_name <chr>
```

get associated protocols:

``` r
ae_get_protocols(x)
#> # A tibble: 1 × 2
#>   accession         protocols
#>       <chr>            <list>
#> 1 E-MEXP-27 <tibble [7 × 10]>
ae_get_protocols(x) %>% unnest()
#> # A tibble: 7 × 11
#>   accession     id                                       accession
#>       <chr>  <int>                                           <chr>
#> 1 E-MEXP-27  79337 Affymetrix:Protocol:Hybridization-EukGE-WS2v4[]
#> 2 E-MEXP-27     51                                        P-AFFY-6
#> 3 E-MEXP-27 209830                                        P-AFFY-7
#> 4 E-MEXP-27 231733                                     P-MEXP-1343
#> 5 E-MEXP-27 231732                                     P-MEXP-1344
#> 6 E-MEXP-27 231734                                     P-MEXP-1345
#> 7 E-MEXP-27 231735                                     P-MEXP-1346
#> # ... with 8 more variables: name <chr>, text <chr>, type <chr>,
#> #   performer <chr>, hardware <chr>, software <chr>,
#> #   standardpublicprotocol <int>, parameter <chr>
```

#### Customized queries:

Use two composable functions to query against rest api. choose api endpoint with `ae_rest_url()` and execute request via `ae_query(field1=value1, field2=value2,...)`. see: <http://www.ebi.ac.uk/arrayexpress/help/programmatic_access.html#Updates>

``` r
ae_rest_url()
#> [1] "https://www.ebi.ac.uk/arrayexpress/json/v3/experiments"
ae_rest_url("protocols") %>% ae_query(species = "saccharomyces cerevisiae", 
                                  keywords = "topoisomerase")
#> Response [https://www.ebi.ac.uk/arrayexpress/json/v3/protocols?species=saccharomyces%20cerevisiae&keywords=topoisomerase]
#>   Date: 2016-12-05 20:49
#>   Status: 200
#>   Content-Type: application/json;charset=UTF-8
#>   Size: 7.17 kB
```

### Deprecated:

``` r
ae_sample_files(x)
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
