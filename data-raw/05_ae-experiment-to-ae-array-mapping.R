library(tidyverse)
library(stringr)

outdir <- "data-raw/scer-ae-sdrf"
if(!dir.exists(outdir)) {
    dir.create(outdir)
}


# download all SDRF files for scer AE experiements ------------------------

urls <- scerden.aemetadb::ae_experiments %>%
    .$accession %>%
    paste0("http://www.ebi.ac.uk/arrayexpress/files/", ., "/", ., ".sdrf.txt")

urls %>% write_lines(file.path(outdir, "urls.txt"))


cmd <- 'cd data-raw/scer-ae-sdrf; cat urls.txt | xargs -n 1 -P 8 wget --continue --no-clobber'
system(cmd)



# Parse SDRF files --------------------------------------------------------

sdrf_files <- list.files(outdir, pattern = "\\.sdrf\\.txt$", full.names = T)

res <- tibble(file = basename(sdrf_files),
       file_lines = sdrf_files %>% map(read_lines, skip = 1L),
       x_experiment = file_lines %>% map(~str_extract(.x, "E-[A-Z]{4}-\\d+")),
       x_array = file_lines %>% map(~str_extract(.x, "A-[A-Z]{4}-\\d+")))

mappings <- res %>%
    select(file, x_experiment, x_array) %>%
    unnest() %>%
    # for those that have didn't match an experiment, fill in with the experiment accession from file name
    mutate(x_experiment = ifelse(is.na(x_experiment), str_extract(file, "E-[A-Z]{4}-\\d+"), x_experiment))
mappings <- mappings %>%
    group_by(x_experiment) %>%
    summarise(array = x_array %>% unique() %>% str_c(collapse = ','))


# 3 options from here:
#   1. join onto arrays table so each array has a experiment = csv of experiments on that platform
#      this is not tractable as that could easy be a very long string (eg. A-AFFY-47 has 250+ expts)
#      also all the experiments that don't have arrays then get merged into one NA
#   2. join onto experiments table, this makes sense.
#   3. separate array <--> experiment accession mapping table.
# use 2. for now to keep it simple
ae_experiments <- scerden.aemetadb::ae_experiments %>%
    left_join(mappings, by = c("accession" = "x_experiment"))
# overwrite new table:
use_data(ae_experiments, overwrite = T)
