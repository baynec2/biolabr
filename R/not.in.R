#` Not in
#' The not-in operator for R.
#' @return
#' @export
#'
#' @examples
#'
#' # Will return rows where carb isn't equal to 1 or 2
#' d1 = dplyr::filter(mtcars,carb %in% c(1,2))
#'
'%nin%' <- function(x,y){
    !('%in%'(x,y))
}



