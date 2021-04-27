#' dtwarper: Takes a data frame containing time series data and applies dynamic time warping.
#'
#' This function generates a distance matrix using dynamic time warping as implemented in the TSclust package.
#'
#' @return a distance matrix.
#' @export
#'
#' @examples
#' # Data frame called data, where each column contains time series data for a different feature ID
#' dist = dtwarper(data, scale = TRUE)
#'
dtwarper = function(data, scale = TRUE){

    # Scaling Data
    if(scale){
        final_data = data %>%
            purrr::map_df(base::scale)

    }else{
        final_data = data %>%
            purrr::map_df(scale)
    }
    # Dynamic Time Warping
    dist = TSclust::diss(SERIES = t(data), METHOD = "DTWARP")

    return(dist)
}
