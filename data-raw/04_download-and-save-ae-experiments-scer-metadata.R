# library(ArrayExpress)  # this is broken, even examples don't work
# q <- queryAE(keywords = "top1", species = "saccharomyces+cerevisiae") # this is broken

library(tidyverse)
library(httr)
library(stringr)

# Get experiments ---------------------------------------------------------

load("data/ae_arrays.rda") # has all

api_results <- tibble(ae_array = ae_arrays$accession,
                      d = ae_array %>% map(scerden.aemetadb::ae_array_experiements))
d <- api_results %>% unnest()

# nice var names
names(d) <- names(d) %>% str_to_lower() %>% str_replace_all(' ', '_')
d <- d %>% rename(ae_experiment = accession)


# check organism variable -------------------------------------------------

pattern <- "Saccharomyces cerevisiae"
d_clean <- d %>% filter(str_detect(organism, pattern))



# array <—> experiment ----------------------------------------------------

ae_links <- d_clean %>%
    select(ae_array, ae_experiment) %>%
    unique()


# Experiments tbl ---------------------------------------------------------

ae_experiments <- d_clean %>%
    select(-ae_array) %>%
    unique()


# Save object -------------------------------------------------------------

use_data(ae_links, overwrite = T)
use_data(ae_experiments, overwrite = T)


