#' find arrays by searching for match in whole table
#' @param x pattern to be used in stringr::str_detect
#' @export
find_in_arrays <- function(x) {
    # make lookup table
    d <- scerden.aemetadb::ae_arrays
    lookup <- tidyr::gather(d, variable, value, -accession)
    lookup <- dplyr::mutate(lookup, value = tolower(value))
    finds <- purrr::map(x, ~dplyr::filter(lookup, stringr::str_detect(value, .x))[["accession"]])
    finds <- purrr::map(finds, unique)
    purrr::map(finds, ~dplyr::filter(d, accession %in% .x))
}
