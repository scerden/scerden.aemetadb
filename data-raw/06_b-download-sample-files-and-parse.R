library(tidyverse)
library(scerden.aemetadb)

load("data/ae_experiments.rda")
experiments <- ae_experiments$ae_experiment
length(experiments)

ae_sample_files_safely <- safely(ae_sample_files)

safe_out <- map(experiments, ae_sample_files_safely)
