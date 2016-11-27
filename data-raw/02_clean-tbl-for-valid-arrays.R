library(tidyverse)
library(stringr)


# read in -----------------------------------------------------------------
orig_tbl <- list.files("data-raw",
                       pattern = "array-express-arrays_scer-tbl",
                       full.names = T) %>%
    read_csv()



# Clean tbl ---------------------------------------------------------------
clean_tbl <- orig_tbl %>%
    select(-files) %>%  # empty col
    # ensure accession is a valid array accession
    filter(str_detect(accession, "A-.{4}-\\d+"))



# save data ---------------------------------------------------------------
# ae_arrays
ae_arrays <- clean_tbl
devtools::use_data(ae_arrays)
# ae_experiments
