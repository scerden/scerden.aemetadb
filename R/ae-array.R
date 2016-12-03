# get array express experiements in tsv file based on experiment:


ae_array_experiements <- function(array) {
    url <- "https://www.ebi.ac.uk/arrayexpress/ArrayExpress-Experiments.txt"
    query <- list(array = array)
    r <- httr::GET(url, query = query)
    tbl_string <- httr::content(r, as = "text")
    readr::read_tsv(tbl_string)
}
