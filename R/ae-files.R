
get_ae_samples <- function(experiment) {
    v3_json_url <- "https://www.ebi.ac.uk/arrayexpress/json/v3/experiments"
    url <- paste0(v3_json_url, '/', experiment, "/samples")
    r <- httr::GET(url)
    stopifnot(httr::status_code(r) == 200)
    out <- httr::content(r, as = "parsed", type = "application/json")
    out$experiment$sample
}

#' get sample files associated with an experiment
#'
#' @param experiment array express exeperiment accession as character string.
#' @examples
#'   # ae_sample_files("E-MEXP-27")
#' @export
ae_sample_files <- function(experiment) {
stopifnot(stringr::str_detect(experiment, "E-[A-Z]{4}-\\d+"))
    sample_l <- get_ae_samples(experiment)
sample_assay_name <- purrr::map_chr(sample_l, c("assay", "name"))
sample_files <- purrr::map(sample_l, "file")
sample_tbl <- purrr::map(sample_files, ~purrr::map_df(.x, tibble::as_tibble))
out <- tibble::tibble(assay_name = sample_assay_name,
       file_tbl = sample_tbl)
out <- tidyr::unnest(out)
out <- dplyr::select(out, -comment)
dplyr::distinct(out)
}

