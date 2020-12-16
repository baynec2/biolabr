#' assign_gel_wells
#'
#' This function is used to format data exported from the band detector software Gel Analyzer (http://www.gelanalyzer.com/) when up to 2x 96 well plates are run on a gel.
#' Lanes 1 and 50 of each section should always contain the molecular weight marker.
#' The lanes of the 96 well gel are always filled in a certain pattern that allows us to determine the Well ID corresponding to a given lane.
#'
#' @param filepath = filepath to excel file containing data exported from GelAnalyzer Software.
#' The file must contain a column labeled "Gel_Section" that specifies which section of the gel the data refers to.

#' @return = tibble containing data with Well ID.
#' @export
#'
#' @examples
#'
#'
#' d1 = assign_gel_wells("/filepath_of_data_exported_from_Gel_Analyzer.xlsx")
#'
#'
assign_gel_wells = function(filepath){

    # Reading in file from
    inital_file = readxl::read_excel(filepath)

    #Defining the pattern linking lane # to well
    col = rep(1:12,each = 2)
    row = c(rep(LETTERS[1:2],12),
            rep(LETTERS[3:4],12),
            rep(LETTERS[5:6],12),
            rep(LETTERS[7:8],12))

    well_id = paste0(row,col)

    #Removing lanes containing the molecular weight ladders
    mod = dplyr::filter(inital_file,
                        `Lane #` != 1,
                        `Lane #` != 50)

    # There can be up to 4 Gel Sections in a single gel.
   # Need to make sure that the lanes match the appropriate well ID.
    mod = dplyr::mutate(mod, `Lane #` = `Lane #` - 1,
                        counter = dplyr::case_when(Gel_Section == 1 ~`Lane #`,
                                                 Gel_Section == 2 ~ `Lane #` + 48,
                                                 Gel_Section == 3 ~ `Lane #`,
                                                 Gel_Section == 4 ~ `Lane #` + 48,
                                                 TRUE ~ 0),
                        intensity = Rf * `Raw volume`)

    # Determining what lanes match to what well ids.
    ordered_well_IDs = well_id[mod$counter]


    mod$Well_ID = ordered_well_IDs
    # Selecting the columns needed.
    final = dplyr::select(mod,Well_ID,Gel_Section,Band_MW = MW,Rf,`Raw volume`,intensity)

    return(final)
}
