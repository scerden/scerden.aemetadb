library(tidyverse)
library(httr)
library(rvest)
library(lubridate)
# if keywords is multiple words need to put + instead of space
keywords <- "Saccharomyces+cerevisiae"

# scrape arrays table for scer --------------------------------------------

# to easily scrape whole table of arrays retrived by request need to put
# them all on one page
url <- "http://www.ebi.ac.uk/arrayexpress/arrays/browse.html"
query <- list(keywords = keywords, page = "1", pagesize = "1000000")
h <- GET(url, query = query)
# html table -> tibble
d <- content(h) %>%
    html_nodes("#ae-browse table") %>%
    .[[2]] %>%
    html_table(fill = T) %>%
    as_tibble()
names(d) <- c("accession", "name", "organism", "files")

destfile <- file.path("data-raw",
                      paste0(as_date(h$date), "_array-express-arrays_scer-tbl.csv")
)

write_csv(d, destfile)
R.utils::gzip(destfile)
