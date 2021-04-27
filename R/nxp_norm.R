#' nxp_norm: Generates an excel file with the info needed to normalize each well of a 96 well plate to a specified concentration at a given volume.
#' The resulting file is intended to serve as input to the Biomek NXP.
#'
#' Notes:
#' 1. This file format was designed to be used with an existing Biomek NXP protocol for gDNA normalization. That is why the collum headers don't indicate what is really in the well.
#' In the future I may go back and fix this to be not so confusing, this was done to be a quick hacky fix.
#' 2. For some reason the biomek NXP seems to allow only whole numbers. If decimal places are found it just ignores the entire number.
#'
#' @param filepath = filepath to flow cytometry results. Note this needs to be a csv file with a column called Gate conatining a Gate named Bacteria.
#' @param dilution_factor = the dilution factor that the flow cytometry wells found at the specified filepath were diluted by.
#' @param target_concentration = the target concentration (cells/mL) you would like in the final solution.
#' @param final_volume  = the final volume in uL that you would like in each well.
#' @param output_filepath = the filepath where you would like the resulting file to be written to.
#'
#' @return
#' @export
#'
#' @examples
#'
#' nxp_norm(filepath = "File from Attune NXT.csv,
#'          dilution_factor = 100,
#'          target_concentration = 5*10^7,
#'          final_volume = 200,
#'          output_filepath = "Location to store output of this function.csv")
#'
nxp_norm = function(filepath,
                    dilution_factor,
                    target_concentration = 5*10^7,
                    final_volume = 200,
                    output_filepath){
    # Reading in data
    data = readr::read_csv(filepath)

    # Mutating the data to generate relevant statistics
    f = data %>%
        dplyr::filter(Gate == "Bacteria") %>%
        dplyr::distinct() %>%
        dplyr::mutate(Cells_mL = Concentration * 1000 * dilution_factor,
                      uL_to_target = round((((final_volume) /1000 * target_concentration)/Cells_mL) * 1000,0),
                      uL_to_target = case_when(uL_to_target > final_volume ~ final_volume,
                                               TRUE ~ uL_to_target),
                      uL_diluent = final_volume - uL_to_target,
                      dilution_factor = 1/(uL_to_target / final_volume)) %>%
        # Getting the column names right
        dplyr::mutate(Source = "Source",
                      Well = "A1",
                      `Water using P20 Tips` = case_when(uL_diluent > 20 ~ 0,
                                                         TRUE ~ uL_diluent) ,
                      `Water using P250 Tips` = case_when(uL_diluent < 20 ~ 0,
                                                          TRUE ~ uL_diluent),
                      `gDNA using P20 Tips` = case_when(uL_to_target > 20 ~ 0,
                                                        TRUE ~ uL_to_target),
                      `gDNA using P250 Tips` = case_when(uL_to_target < 20 ~ 0,
                                                         TRUE ~ uL_to_target),
                      `Position_1` = "DNA_Norm_WaterOnly",
                      `Position_2` = "DNA_Norm_gDNA",
                      Destination = Sample
                    ) %>%
        dplyr::select(Source,Well,`Water using P20 Tips`,`Water using P250 Tips`, `gDNA using P20 Tips`,
                      `gDNA using P250 Tips`,`Position_1`,`Position_2`,Destination) %>%
        dplyr::arrange(desc(`Water using P250 Tips`),
                       desc(`Water using P20 Tips`))

    readr::write_csv(f,output_filepath)
}


