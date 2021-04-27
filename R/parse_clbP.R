#' parse_clbP
#'
#' This function takes the exported .txt file from the clbP_probe protocol on a biotek plate reader and parses the data into a tidy data frame containg the OD600 and fluorescence,
#'
#' @param biotek_export
#' @param Plate_Type
#'
#' @return a tidy data frame with OD600 and fluorescence from activity based probe
#' @export
#'
#' @examples
parse_clbP = function(biotek_export, Plate_Type = 96 ){

    if(Plate_Type == 384){
        raw_data = read.delim(biotek_export,row.names = NULL,header = FALSE,col.names = 1:385,na.strings = c("?????",""),stringsAsFactors = FALSE)
    }else if(Plate_Type == 96){
        raw_data = read.delim(biotek_export,row.names = NULL,header = FALSE,col.names = 1:97,na.strings = c("?????",""),stringsAsFactors = FALSE)
    }else{
        print("Only 96 or 384 well plates are supported")
        stop(call. = TRUE)
    }
    #We need to define known places on the export file so we can scrape the necessary data
    Plate_ID_Index = which(stringr::str_detect(raw_data$X1,"Barcode:"))
    Read_2_Index = which(stringr::str_detect(raw_data$X1,"Read 2.*"))
    #Initalizing the dataframe to store the tidy OD600 dataframe
    OD600_output = data.frame()
    #Now we need to loop through the export file and put the OD600 data in a tidy format
    for(i in Plate_ID_Index) {
        #Scrapes the Sample ID Prefix to determine the sample ID of the well
        Sample_ID_Prefix = paste0(as.character(raw_data[i,2]),".")

        #Need to determine the length of the OD600 data in the ezport files
        Length_index = Read_2_Index[1] - Plate_ID_Index[1] -6

        #Defining the header of the
        Header = raw_data[i + 4,]
        Header = sapply(Header,as.character)
        OD600_data = raw_data[i + 5 : (5 + Length_index), ]
        colnames(OD600_data) = Header

        #Need to exclude the time measurements from the biotek export file that were not actually measyred
        not_na = !is.na(OD600_data$A1)
        necessary_rows = sum(not_na)
        OD600_data = OD600_data[1:necessary_rows,]

        #Putting the data in a tidy format
        tidy_OD600_data = tidyr::gather(OD600_data,Well,OD600,2:(Plate_Type + 1)) %>%
            dplyr::mutate(Sample.ID = paste0(Sample_ID_Prefix,Well)) %>%
            dplyr::select(Sample.ID,Well,Time,OD600)

        #outputing the tidy OD600 data
        OD600_output = rbind(OD600_output,tidy_OD600_data)
    }
    ###Now we need to do the same thing for the pH data that we just did for the OD600 data. ###

    #Initalizing the dataframe to store the tidy pH dataframe
    Read_2_output = data.frame()
    for(i in Read_2_Index){

        #Grabing the sample ID
        iteration = which(Read_2_Index == i)
        Plate_ID_location = Plate_ID_Index[iteration]
        Sample_ID_Prefix = paste0(as.character(raw_data[Plate_ID_location,2]),".")

        #Defining the length to grab, there are two rows between the "pH Final" and the data of interest
        length = necessary_rows + 1
        Read_2_data = raw_data[(i + 2) : (i + length),]

        #Defining the header columns
        Header = raw_data[i+1,]
        Header = sapply(Header,as.character)
        colnames(Read_2_data) = Header

        #Converting the data to a tidy format
        tidy_Read_2_data = tidyr::gather(Read_2_data,Well,clbP_intensity,2:(Plate_Type+1)) %>%
            dplyr::mutate(Sample.ID = paste0(Sample_ID_Prefix,Well)) %>%
            dplyr::select(Sample.ID,Well,Time,clbP_intensity)

        #outputing the tidy pH data
        Read_2_output = rbind(Read_2_output,tidy_Read_2_data)
    }
    #Need to change the timepoints so that pH and OD600 match. The plate reader exports them in a format that is too granular.
    #It will be much more convienent to make the timepoints for pH and OD600 match.
    #To do this, lets simpily take the OD600 times and give them to the pH Times
    Standardized_Time = OD600_output$Time
    Read_2_output$Time = Standardized_Time

    #Combining the pH and OD600 data
    combined_data = dplyr::inner_join(OD600_output,Read_2_output, by = c("Sample.ID","Time")) %>%
        dplyr::select(-c(2,5)) %>%
        dplyr::mutate(OD600 = as.numeric(OD600),
                      clbP_intensity = as.numeric(clbP_intensity),
                      Time = lubridate::hms(Time),
                      Time = lubridate::hour(Time) + (lubridate::minute(Time)/60))


    # returning the final data frame.
    return(combined_data)
}
