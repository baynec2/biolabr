#' facet_R2
#'
#' This function is used to calculate the R^2 values for different facets.
#' This makes it easy to add R^2 values to different facets of a ggplot using the geom_text function.
#'
#' @param df data frame
#' @param y y axis name
#' @param x x axis name
#' @param by name of the factor used to split the data into facets.
#'
#' @return a data frame containing the R^2 values for the linear model from each facet.
#' @export
#'
#' @examples
#'
#' data(mtcars)
#'
#' R2 = facet_R2(mtcars,y = "mpg",x = "hp",by = "gear")
#'
#' p1 = ggplot(mtcars,aes(mpg,hp))+
#' geom_point()+
#' geom_smooth(method = "lm")+
#' facet_grid(~gear)+
#' geom_text(data = R2,aes(x = 30, y = 300,label = R2))
#'
#' p1
#'
facet_R2 = function(df,y,x,by){

    #R2 calc
    R2 = function(df){
        m = lm(dplyr::pull(df,y)~dplyr::pull(df,x),data = df)
        r2 = round(summary(m)$r.squared,3)
        return(r2)
    }


    eqns = by(df, dplyr::pull(df,by), R2)

    df2 = data.frame(R2 = unclass(eqns))
    df2 = tibble::rownames_to_column(df2)


    names(df2) = c(by,"R2")



    return(df2)
}
