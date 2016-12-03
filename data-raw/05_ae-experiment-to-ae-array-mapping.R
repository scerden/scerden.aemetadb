# The only way I have figured out how to get array (platform)

# Prelims -----------------------------------------------------------------

library(tidyverse)
library(stringr)

outdir <- "data-raw/scer-ae-sdrf"
if(!dir.exists(outdir)) {
    dir.create(outdir)
}


# download all SDRF files for scer AE experiements ------------------------

load("data/ae_experiments.rda")

urls <- ae_sdrf_url(ae_experiments$ae_experiment)

urls %>% write_lines(file.path(outdir, "urls.txt"))


cmd <- 'cd data-raw/scer-ae-sdrf; cat urls.txt | xargs -n 1 -P 8 wget --continue --no-clobber'
system(cmd)



# Parse SDRF files --------------------------------------------------------

sdrf_files <- list.files(outdir, pattern = "\\.sdrf\\.txt$", full.names = T)


res <- tibble(ae_experiment = basename(sdrf_files) %>% str_replace("\\.sdrf\\.txt$", ""),
              sdrf_lines = sdrf_files %>% map(read_lines, skip = 1L))

res %>% head() %>% unnest() %>% glimpse()
# experiment acc regex: "E-[A-Z]{4}-\\d+"
res %>%
    head() %>%
    .$sdrf_lines %>%
    map(~str_extract(.x, "A-[A-Z]{4}-\\d+"))
