library(tidyverse)


list.files("data-raw",
           pattern = "array-express-arrays_scer-tbl",
           full.names = T) %>%
    file.remove()
