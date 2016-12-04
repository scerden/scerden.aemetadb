library(tidyverse)
library(stringr)
library(scerden.aemetadb)

load("data/ae_experiments.rda")
experiments <- ae_experiments$ae_experiment
length(experiments)
# ae_sample_files fxn from: http://www.ebi.ac.uk/arrayexpress/help/programmatic_access.html#Files
ae_sample_files_safely <- safely(ae_sample_files)

outfile <- "data-raw/2016-12-03_safe-out.rds"
if(!file.exists(outfile)) {
    safe_out <- map(experiments, ae_sample_files_safely)
    write_rds(safe_out, outfile)
}
safe_out <- read_rds(outfile)
out <- safe_out %>% map("result")
out <- bind_rows(out, .id = "index")
out <- out %>%
    nest(-index) %>%
    mutate(ae_experiment = experiments[as.integer(index)]) %>%
    select(ae_experiment, data) %>%
    unnest()
out
out %>% filter(type == "data") %>% filter(str_detect(name, "\\.[c|C][e|E][l|L]"))
out %>% filter(name != basename(url)) # sanity check
out %>% select(url)
out %>% count(type)

ae_samples <- out
use_data(ae_samples, overwrite = T)
