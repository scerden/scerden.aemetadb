#' Show the url for a given Array Express REST API
#'
#' @param api <chr> which api
#' @param rettype <chr> which format return type
#' @param version <chr> which version of api
#' @return <chr> url of API endpoint
#' @export
ae_rest_url <- function(api = c("experiments", "files", "protocols"),
                     rettype = c("json", "xml"),
                     version = "v3") {
    api <- match.arg(api)
    rettype <- match.arg(rettype)
    version <- match.arg(version)
    sprintf("https://www.ebi.ac.uk/arrayexpress/%s/%s/%s",
            rettype, version, api)
}


# QUERY -------------------------------------------------------------------


#' general query against api
#' @param url <chr> of url endpoint to query, see ae_rest_url()
#' @param ... query parameters
#' @return httr::GET response object
#' @details http://www.ebi.ac.uk/arrayexpress/help/programmatic_access.html
#' @examples
#'   ae_query(keywords = "cancer")
#'   ae_rest_url("files") %>% ae_query(array = "A-AFFY-33")
#' @export
ae_query <- function(url = ae_rest_url(), ...) {
    query <- purrr::map(as.list(match.call()[c(-1, -2)]), eval)
    httr::GET(url = url, query = query)
}



# direct get --------------------------------------------------------------

#' get files associated with an accession
#' @param accession <chr> Array Express Experiment accession
#' @param tidy <lgl> should the response contents be tidied up?
#' @return a tidy tibble by default, httr::GET response object if tidy = F
#' @export
ae_get_files <- function(accession, tidy = T) {
    ae_get(accession, tidy, api = "files", tidy_files_response)
}

#' @rdname ae_get_files
#' @export
ae_get_protocols <- function(accession, tidy = T) {
    ae_get(accession, tidy, api = "protocols", tidy_protocols_response)
}

#' @rdname ae_get_files
#' @export
ae_get_samples <- function(accession, tidy = T) {
    ae_get(accession, tidy, api = "samples", tidy_samples_response)
}


ae_get <- function(accession, tidy, api, tidying_fxn) {
    validate_ae(accession)
    if(api == "samples") {
        # the samples api is really an experiment endpoint eg:
        # https://www.ebi.ac.uk/arrayexpress/json/v3/experiments/E-xxxx-nnnnn/samples
        url <- paste(ae_rest_url("experiments"), accession, api, sep = '/')
    }else{
        url <- paste(ae_rest_url(api), accession, sep = '/')
    }
    r <- httr::GET(url)
    if(!tidy) {
        return(r)
    }
    tidying_fxn(r)
}


# tidying functions -------------------------------------------------------

tidy_files_response <- function(r) {
    stopifnot(httr::status_code(r) == 200L)

    l <- httr::content(r)
    lsub <- l[["files"]]

    stopifnot(lsub[["total-experiments"]] == 1L)

    # tidy individual file list object
    tidy_file <- function(x) {
        out <- purrr::map_if(x, ~is.null(.x), ~ NA_character_)
        out <- purrr::map_if(out, ~length(.x) > 1, paste0, collapse = ',')
        tibble::as_tibble(out)
    }

    tibble::tibble(
        accession = lsub$experiment$accession,
        files = list(purrr::map_df(lsub$experiment$file, tidy_file))
    )
}



tidy_samples_response <- function(r) {
    stopifnot(httr::status_code(r) == 200L)
    l <- httr::content(r)

    x <- l$experiment$sample[[1]]

    # tidy individual sapmle list object
    tidy_sample <- function(x) {
        # assay section
        assay_name <-  x$assay$name
        # characteristic section
        characteristics <-  list(purrr::map_df(x$characteristic,
               ~tidyr::unite(tibble::as_tibble(.x),
                             category_value, category, value, sep = "=")))
        # extract
        # file
        files <- list(purrr::map_df(x$file, ~purrr::update_list(.x, comment = NULL)))
        # labeled-extract
        # scan
        scan_name = x$scan$name
        # source
        source_name = x$source$name

        tibble::tibble(assay_name, characteristics, files, scan_name, source_name)
    }

    tibble::tibble(accession = l$experiment$accession,
                   samples = list(purrr::map_df(l$experiment$sample, tidy_sample)))
}



tidy_protocols_response <- function(r) {
    stopifnot(httr::status_code(r) == 200L)
    l <- httr::content(r)

    # tidy individual protocol list object
    tidy_protocol <- function(x) {
        out <- purrr::map_if(x, ~is.null(.x), ~ NA_character_)
        out <- purrr::map_if(out, ~length(.x) > 1, paste0, collapse = ',')
        tibble::as_tibble(out)
    }

    tibble::tibble(
        accession = basename(r$url),
        protocols = list(purrr::map_df(l$protocols$protocol, tidy_protocol))
    )
}

# HELPERS -----------------------------------------------------------------


# http://www.ebi.ac.uk/arrayexpress/help/accession_codes.html
validate_ae <- function(accession) {
    is_valid <- stringr::str_detect(accession, "^(A|E)-([A-Z]{4})-(\\d+)$")
    if(!is_valid) {
        stop("invalid AE accession")
    }
}
