#' parse_gas_data
#'
#' This function is intended to parse the exported data from the Ankom Gas System software into a format that is easy to work with.
#' @param filepath The file path of the exported file from the Ankom Gas System software. Should be an .xls file
#'
#' @return a tibble containing the parsed data
#' @export
#'
#' @examples
#' formatted_data = parse_gas_data("filepath_of_the_xls_file_exported_by_GPM_software")
parse_gas_data = function(filepath){

    sheets = readxl::excel_sheets(filepath)

    Data = readxl::read_xls(filepath,sheets[[1]]) %>%
        dplyr::rename(Date = 1,Reference = 2)

    T0 = Data[[1,1]]

    Data = Data %>%
        dplyr::mutate(Date = as.POSIXct(Date),
                      Time_hr =  as.numeric(round(((Date - T0) /3600),2))) %>%
        dplyr::select(Time_hr,everything(),-Date) %>%
        tidyr::pivot_longer(2:ncol(.),"Sample.ID",values_to = gsub(" ","_",sheets[[1]])) %>%
        na.omit()

    for(i in sheets[2:length(sheets)]){

        loop = readxl::read_xls(filepath,i) %>%
            dplyr::rename(Date = 1,Reference = 2)

        T0 = loop[[1,1]]

        loop = loop %>%
            dplyr::mutate(Date = as.POSIXct(Date),
                          Time_hr =  as.numeric(round(((Date - T0) /3600),2))) %>%
            dplyr::select(Time_hr,everything(),-Date) %>%
            tidyr::pivot_longer(2:ncol(.),"Sample.ID",values_to = gsub(" ","_",i)) %>%
            na.omit()

        Data = dplyr::inner_join(Data,loop, by = c("Time_hr","Sample.ID"))
    }

    return(Data)
}
