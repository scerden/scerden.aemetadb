# Want all the .cel files that come from yeast platforms in array express:
# parse all the sdrf files that are associated with a scer experiment
# for fields that match the .cel extension somewhere.

# Prelims -----------------------------------------------------------------

library(tidyverse)
library(stringr)
# previously donwloaded:
outdir <- "data-raw/scer-ae-sdrf"
sdrf_files <- list.files(outdir, pattern = "\\.sdrf\\.txt$", full.names = T)



# Parse SDRF files --------------------------------------------------------


# reads in the tsv SDRF file and reshapes it so that each field is in one
# value colum then filter that tbl for cel patern.
get_celfields <- . %>%
    read_tsv(skip = 1, col_names = F) %>%
    gather(variable, value) %>%
    filter(str_detect(value, "\\.[C|c][E|e][L|l]"))

celfields <- sdrf_files %>% map(get_celfields)

res <- tibble(ae_experiment = basename(sdrf_files) %>% str_replace("\\.sdrf\\.txt$", ""),
       cel_value = celfields) %>%
    unnest()

ae_cel_files <- res %>% select(-variable) %>% unique() %>% group_by(ae_experiment) %>% summarise(cel_files = list(value))


# save object -------------------------------------------------------------
# each array experiment with associated cel files as a chr list
ae_cel_files
use_data(ae_cel_files, overwrite = T)
