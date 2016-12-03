# get array express experiements in tsv file based on experiment:


ae_array_experiements <- function(array) {
    stopifnot(stringr::str_detect(array, "A-[A-Z]{4}-\\d+"))
    url <- "https://www.ebi.ac.uk/arrayexpress/ArrayExpress-Experiments.txt"
    query <- list(array = array)
    r <- httr::GET(url, query = query)
    tbl_string <- httr::content(r, as = "text")
    readr::read_tsv(tbl_string)
}

ae_sdrf_url <- function(experiment) {
    stopifnot(stringr::str_detect(experiment, "E-[A-Z]{4}-\\d+"))
    url <- paste0("http://www.ebi.ac.uk/arrayexpress/files/", acc, "/", acc, ".sdrf.txt")
}
