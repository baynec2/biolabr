#' format_CFU
#' This function is used to parse an excel template containing colony counts and metadata corresponding to CFU spots on agar plates and assign the appropriate sample.IDs.
#' Note that this function assumes that 2uL is plated for each spot.
#'
#' @param Filepath = The file path to the filled out excel template containing the colony counts and metadata . This must be the specific excel template designed for use with this function
#' @param Dilution_orientation = Specify whether the dilution is oriented row wise or plate wise.
#'
#' @return = a data frame with the calculated CFU/mL for each Sample.ID
#' @export
#'
#' @examples
#' df = format_CFU(Filepath = "/filepath",Dilution_orientation = "Row")
#'
format_CFU = function(Filepath,Dilution_orientation = "Row"){

#Code for formating if the dilutions are arranged Row wise.
    if(Dilution_orientation == "Row"){
    #Reading in the filled in Excel file Template.
        Sheets = readxl::excel_sheets(Filepath)
        output = data.frame()
            for( i in Sheets) {
                Data = readxl::read_excel(Filepath,sheet = i,col_names = FALSE)
                output = plyr::rbind.fill(output,Data)
                output
            }

        Data = output[,1:15]
        names(Data) = paste0("...",1:15)

        #Getting an Index to use as a reference. Here we will be using the Well containing the text Plate Number.
        Index = which(stringr::str_detect(Data$...1,"Plate Number"))

        output_vector = vector()
            for(i in Index) {
                list = 4:15
                for(n in list){
                    Data_2 = as.vector(Data[((i+3):(i + 10)),n])
                    output_vector = c(output_vector,Data_2)
                }
            }

        #Assigning the Appropriate Well_IDs
        Well_ID = vector()
        Columns = rep(1:12,each =8)
        Row_Index = which(stringr::str_detect(Data$...4,"Row"))
        rows_vector = vector()

            for(i in Row_Index) {
                Data_3 = as.vector(Data[(i+1),4])
                rows_vector = c(rows_vector,Data_3)
            }

        Rows = rep(rows_vector,each = 96)

        Well_ID = paste0(Rows,Columns)

        #Extracting the corresponding Dilutions
        Dilution_vector = vector()
        Dilution_Index = which(stringr::str_detect(Data$...2,"Dilution"))
            for(i in Dilution_Index) {
                Dilution = Data[(i+1):(i+8),2]
                Dilution_temp = rep(gsub("Dilution ","",x = Dilution),12)
                Dilution_vector = c(Dilution_vector,Dilution_temp)
            }

        #Extracting the corresponing Plate numbers
        Plate_number_vector = vector()

            for(i in Index){
                Plate_number = output[(i +1), 1]
                Plate_number_temp = rep(Plate_number,96)
                Plate_number_vector = c(Plate_number_vector,Plate_number_temp)
            }

        #Extracting the corresponding Media
        Media_Index = which(stringr::str_detect(Data$...2,"Media Type"))
        Media_vector = vector()
            for(i in Media_Index) {
                Media = Data[(i+1),2]
                Media_temp = rep(Media,96)
                Media_vector = c(Media_vector,Media_temp)
            }

        #Extracting the Incubating Condition
        Condition_Index = which(stringr::str_detect(Data$...3,"Condition"))
        Condition_vector = vector()
            for(i in Condition_Index) {
                Condition = Data[(i+1),3]
                Condition_temp = rep(Condition,96)
                Condition_vector = c(Condition_vector,Condition_temp)
            }

        #Extracting the length of incubation
        Length_Index = which(stringr::str_detect(Data$...5,"Length of incubation"))
        Length_vector = vector()
            for(i in Length_Index) {
                Length = Data[(i+1),5]
                Length_temp = rep(Length,96)
                Length_vector = c(Length_vector,Length_temp)
            }

        Data_frame = as.data.frame(cbind(Plate_number_vector,Dilution_vector,Media_vector,Condition_vector,Length_vector,Well_ID,output_vector))

        names(Data_frame) = c("PlateNumber","Dilution","Media"," Condition","Length_of_Incubation","Well","Colony_Count")


        #Changing Class from factor to integer
        Data_frame$Dilution = as.integer(as.character(Data_frame$Dilution))
        Data_frame$Colony_Count = as.integer(as.character(Data_frame$Colony_Count))

        #Finalizing the Data Frame
        Hand_Count = Data_frame


        #Calculating CFUs/mL assuming that 2uL was plated.
        Hand_Count = dplyr::mutate(Hand_Count, Sample_ID = paste0(PlateNumber,".",Well),
                            Dilution_Factor = 10^Dilution,
                            CFU_mL = Colony_Count*Dilution_Factor*500)

        Hand_Count = dplyr::select(Hand_Count, Sample_ID, everything())

        Hand_Count = dplyr::filter(Hand_Count,!is.na(CFU_mL))

    return(Hand_Count)
    }
    if(Dilution_orientation == "Plate"){

        #Extracting the Counts to a Data frame
        Sheets = readxl::excel_sheets(Filepath)
        output = data.frame()
            for( i in Sheets) {
                Data = readxl::read_excel(Filepath,sheet = i,col_names = FALSE)
                output = plyr::rbind.fill(output,Data)
                output
            }

        Data = output[,1:14]
        names(Data) = paste0("..",1:14)
        Index = which(stringr::str_detect(Data$..1,"Plate Number"))

        output = data.frame()
            for(i in Index) {
                Data_2 =  data.frame(Data[(i-1):(i + 8),])
                output = dplyr::bind_rows(output,Data_2)
            }
        Index_2 = which(stringr::str_detect(output$..1,"Plate Number"))

        output_vector = vector()
            for( i in Index_2){
                list = 3:14
                for(n in list){
                    Data_3 = output[((i+1):(i + 8)),n]
                    output_vector = c(output_vector,Data_3)
                }
            }

        #Assigning the Appropriate Well_IDs
        Well_ID = vector()
        Columns = 1:12
            for( i in Columns){
                Temp = paste0(c("A","B","C","D","E","F","G","H"),i)
                Well_ID = c(Well_ID,Temp)
            }


        #Extracting the corresponding Dilutions
        Dilution_vector = vector()
            for(i in Index_2) {
                Dilution = output[(i-1),3]
                Dilution_temp = rep(gsub("Dilution ","",x = Dilution),96)
                Dilution_vector = c(Dilution_vector,Dilution_temp)
            }

        #Extracting the corresponing Plate numbers
        Plate_number_vector = vector()
            for(i in Index_2){
                Plate_number = output[(i +1), 1]
                Plate_number_temp = rep(Plate_number,96)
                Plate_number_vector = c(Plate_number_vector,Plate_number_temp)
        }

        #Extracting the corresponding Media
        Index_Media = (Index_2-1)
        Media = output[Index_Media,1]
        Media_vector = rep(Media,each = 96)

        #Extracting the Incubating Condition
        Index_Condition = Index_Media
        Condition = output[Index_Condition,2]
        Condition_vector = rep(Condition,each = 96)


        #Extracting the length of incubation
        Index_Length = Index_Media
        Length = output[Index_Media,4]
        Length_vector = rep(Length, each = 96)

        Data_frame = as.data.frame(cbind(Plate_number_vector,Dilution_vector,Media_vector,Condition_vector,Length_vector,Well_ID,output_vector))

        names(Data_frame) = c("PlateNumber","Dilution","Media"," Condition","Length_of_Incubation","Well","Colony_Count")


        #Changing Class from factor to integer
        Data_frame$Dilution = as.integer(as.character(Data_frame$Dilution))
        Data_frame$Colony_Count = as.integer(as.character(Data_frame$Colony_Count))

        #Finalizing the Data Frame
        Hand_Count = Data_frame

        Hand_Count = dplyr::mutate(Hand_Count, Sample_ID = paste0(PlateNumber,".",Well),
                             Dilution_Factor = 10^Dilution,
                             CFU_mL = Colony_Count*Dilution_Factor*500)

        Hand_Count = dplyr::select(Hand_Count, Sample_ID, dplyr::everything())

        Hand_Count = dplyr::filter(Hand_Count,!is.na(CFU_mL))

        return(Hand_Count)
    }
    else{
        print("The only accepted dilution formats are \"Row\" and \"Plate\"")
    }
}


