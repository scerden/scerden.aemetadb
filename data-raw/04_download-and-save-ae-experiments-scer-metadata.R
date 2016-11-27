# library(ArrayExpress)  # this is broken, even examples don't work
# q <- queryAE(keywords = "top1", species = "saccharomyces+cerevisiae") # this is broken

library(tidyverse)
library(httr)
library(stringr)

query <- "Saccharomyces cerevisiae"

# all array express experiments for scer ----------------------------------
# api to download tsv format file
url <- "http://www.ebi.ac.uk/arrayexpress/ArrayExpress-Experiments.txt"
keywords <- str_replace_all(query, ' ', '+')
h <- GET(url, query = list(keywords = keywords))
h$status_code
d <- content(h) %>% read_tsv()
d %>% glimpse()



# check organism variable -------------------------------------------------

d <- d %>% filter(str_detect(Organism, query))
# nice var names
names(d) <- names(d) %>% str_to_lower() %>% str_replace_all(' ', '_')



# Save object -------------------------------------------------------------
ae_experiments <- d
use_data(ae_experiments)
