#' sequencing_platemapper
#'
#' @param metadata = This is the metadata that will be used to create the sequecning plate maps. The sample.ID can be labeled whatever, but it has to be in the first column
#' @param Quadrants_to_use = This specifies how many quadrants will be transferred.
#'
#'Right now it only works if the samples are in row wise order. This needs to be fixed. I will update this when it is fixed.
#' @return a matrix containing a visual representation of the plate maps to send for sequencing. This can then be wrote as any file type the user wants
#' (ex using write.csv)
#'
#'
#' @export
#'
#' @examples
sequencing_platemaper = function(metadata,Quadrants_to_use = 4){
    #Defining the wells in each quadrant by row and column
    even_quad_col = rep(seq(2,24,by = 2), 8)
    odd_quad_col=  rep(seq(1,24,by = 2),8)
    top_quad = rep(LETTERS[seq(1,16,by = 2)],each = 12)
    bottom_quad = rep(LETTERS[seq(2,16,by = 2)],each = 12)
    #Defining the wells in each quadrant
    Q1_wells = paste0(top_quad,odd_quad_col)
    Q2_wells = paste0(top_quad,even_quad_col)
    Q3_wells = paste0(bottom_quad,odd_quad_col)
    Q4_wells = paste0(bottom_quad,even_quad_col)


    #Only including the quadrants that we desire to transfer to sequencing plates.
    if(Quadrants_to_use == 1){

        Sample.IDs = dplyr::select(metadata,Sample.ID = 1 ) %>%
            dplyr::mutate(Plate_ID = stringr::str_extract(Sample.ID,".*(?=\\.[A-P]\\d*$)"),
                          Well = stringr::str_extract(Sample.ID,"[A-P]\\d*$"),
                          Quad = ifelse(Well %in% Q1_wells,
                                        "Q1",
                                        ifelse(Well %in% Q2_wells,
                                               NA,
                                               ifelse(Well %in% Q3_wells,
                                                      NA,
                                                      ifelse(Well %in% Q4_wells,
                                                             NA,NA)))),
                          Seq_Plate_ID = paste0(Plate_ID,".",Quad)
            ) %>%
            dplyr::filter(!is.na(Quad))
    }
    if(Quadrants_to_use == 2){

        Sample.IDs = dplyr::select(metadata,Sample.ID = 1) %>%
            dplyr::mutate(Plate_ID = stringr::str_extract(Sample.ID,".*(?=\\.[A-P]\\d*$)"),
                          Well = stringr::str_extract(Sample.ID,"[A-P]\\d*$"),
                          Quad = ifelse(Well %in% Q1_wells,
                                        "Q1",
                                        ifelse(Well %in% Q2_wells,
                                               "Q2",
                                               ifelse(Well %in% Q3_wells,
                                                      NA,
                                                      ifelse(Well %in% Q4_wells,
                                                             NA,NA)))),
                          Seq_Plate_ID = paste0(Plate_ID,".",Quad)
            ) %>%
            dplyr::filter(!is.na(Quad))
    }
    if(Quadrants_to_use == 3){

        Sample.IDs = dplyr::select(metadata,Sample.ID = 1) %>%
            dplyr::mutate(Plate_ID = stringr::str_extract(Sample.ID,".*(?=\\.[A-P]\\d*$)"),
                          Well = stringr::str_extract(Sample.ID,"[A-P]\\d*$"),
                          Quad = ifelse(Well %in% Q1_wells,
                                        "Q1",
                                        ifelse(Well %in% Q2_wells,
                                               "Q2",
                                               ifelse(Well %in% Q3_wells,
                                                      "Q3",
                                                      ifelse(Well %in% Q4_wells,
                                                             NA,NA)))),
                          Seq_Plate_ID = paste0(Plate_ID,".",Quad)
            ) %>%
            dplyr::filter(!is.na(Quad))
    }


if(Quadrants_to_use == 4){

    Sample.IDs = dplyr::select(metadata,Sample.ID = 1) %>%
        dplyr::mutate(Plate_ID = stringr::str_extract(Sample.ID,".*(?=\\.[A-P]\\d*$)"),
                      Well = stringr::str_extract(Sample.ID,"[A-P]\\d*$"),
                      Quad = ifelse(Well %in% Q1_wells,
                                    "Q1",
                                    ifelse(Well %in% Q2_wells,
                                        "Q2",
                                        ifelse(Well %in% Q3_wells,
                                        "Q3",
                                    ifelse(Well %in% Q4_wells,
                                        "Q4",NA)))),
                      Seq_Plate_ID = paste0(Plate_ID,".",Quad)
        ) %>%
        dplyr::filter(!is.na(Quad))
}
#Assembling the final table.
    final = matrix(ncol = 13)
    for(i in unique(Sample.IDs$Seq_Plate_ID)){

        plate_contents = Sample.IDs %>%
            filter(Seq_Plate_ID == i) %>%
            pull(1)

        Plate_ID = i

        p1 = matrix(plate_contents,8,byrow = TRUE)

        labels = rbind(c(i,rep("",11)),1:12)

        f = rbind(labels,p1)

        temp = cbind(c(rep("",2),LETTERS[1:8]),f)
        final = rbind(final,temp)
    }
    return(as.data.frame(final,row.names = FALSE))
}


