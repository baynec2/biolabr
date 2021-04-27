#' find_n_similar: Find the most similar patterns to a pattern of interest.
#'
#' This function is designed to work in combination with dtwarper.
#' Dtwarper is intended to generate a distance matrix using dynamic time warping, which is then leveraged by find_n_similar() to find n IDs that produce the most similar patterns.
#'
#' @return: A vector of IDs sorted by their similarity to the POI: pattern of interest
#' @export
#'
#' @examples
#'# dist generated with dtwarper is used to find IDs producing the 25 most similar patterns to that of the "interesting pattern".
#'IDs = find_n_similar(dist,interesting_pattern, n = 25)
find_n_similar = function(dist, POI_name, n = 10){

    dist_t = as.matrix(dist)%>%
        as.data.frame() %>%
        tibble::rownames_to_column("ID") %>%
        tibble::as_tibble()

    similar_to_POI = dist_t %>%
        dplyr::select(ID,POI_name) %>%
        dplyr::filter(ID != POI_name) %>%
        dplyr::arrange(dplyr::across(POI_name))

    n = similar_to_POI[1:n,] %>%
        dplyr::pull(ID)

    return(n)

}
