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
