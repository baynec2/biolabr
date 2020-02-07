#' Genewiz_16S
#'
#' This function is designed to be a consise method to determine the taxonomy of several samples that have been sent for 16S sanger sequnecing.
#'
#' The function does this by generating consensus sequences from a folder containing several forward and reverse 16S sanger sequencing reads and then BLASTs them against the NCBI database.
#' This folder containing the foward and reverse reads is intended to be obtained through Genewiz 16S although it doesn't necessarily have to have been for the function to work.
#' The files must have the following naming conventions though.
#'
#' In the folder containing all of the data, the forward read for any given sample name should be followed by SeqF.ab1. ex "Sample1SeqF.ab1"
#'
#' The reverse read for the same sample should be the same sample name followed by SeqR.ab1. ex "Sample1SeqR.ab1"
#'
#' This function is designed to handle any number of paired forward and reverse samples in the inital input folder.
#'
#' This function also depends on the user having installed blast on their computer. This can be done by going to ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
#' The user will then have to download the 16SMicrobial database. This can be downloaded at ftp://ftp.ncbi.nlm.nih.gov/blast/db/v4/
#'
#' Once blastn is downloaded the user will then need to provide a database that converts the NCBI acession number to the actual taxonomy.
#' This can be done by using the prepareDatabase('accessionTaxa.sql') function that is part of the taxonomizer package (https://github.com/sherrillmix/taxonomizr).
#' Note that it is best to store the acessionTaxa database somewhere central because it is quite large (~60 GB).
#'

#'
#' @param folder_path This is the path to the folder containing the forward and reverse 16S reads.
#' @param blast_db_path This is the path to the 16SMicrobial database
#' @param accessionToTaxa_path This is the path to the accessionTaxa.sql database.
#' @param similarity This is the similarity cutoff to consider (entered as a percentage). If multiple taxa are reported to have the given level of similarity,
#' the most granular level of taxonomy where there is consensus will be returned.
#'
#' @return a dataframe containing the taxonomy assignmets corresponding with the samples in the folder path.
#' @export
#'
#' @examples
#' taxa = Genewiz_16S("Folder_with_Genewiz_Results",
#' blast_db_path = "where_I_store_the_16SMicrobial_database",
#' accessionToTaxa_path = "where_I_store the acessionTaxa.sql_file_I_got_by_using_taxonomizer_package"
#' similarity = 99)
Genewiz_16S = function(folder_path,
                      blast_db_path = file.path("/Volumes/kaleidobio/Shared/D2/Departments/Research/Biology/biolabr/16SMicrobial/16SMicrobial"),
                      accessionToTaxa_path = file.path("/Volumes/kaleidobio/Shared/D2/Departments/Research/Biology/biolabr/accessionTaxa.sql"),
                      similarity = 99) {
    #Loading the DNA sequences from the genewiz files and making consensus sequences.
    p1 = sangeranalyseR::make.consensus.seqs(folder_path,
                                             forward.suffix = "SeqF.ab1",
                                             reverse.suffix = "SeqR.ab1")

    # Assigning names to each consensus sequence.
    seq = p1$consensus.sequences

    names(seq) = stringr::str_match(names(seq),"//(.*)-16S-")[,2]


    #Blasting

    #For this to work, I had to provide the stem name of the files in the DB which here is "16SMicrobial".
    #You also need to have blast installed on your computer.

    db = rBLAST::blast(db=blast_db_path)

    output = data.frame()

    #uses taxa with the provided similarity identity or more in order to assign taxa for each of the sequences in the genewiz file.

    for(i in 1:length(seq)){
        temp = predict(db,seq[i]) %>%
            dplyr::filter(Perc.Ident >= similarity)
        output = rbind(output,temp)
    }

    #Now that we have the NCBI acession number, we need to figure out what the corresponding taxa is. We can get that using the accessionTaxa.sql database.
    output = output %>%
        dplyr::mutate(SubjectID = as.character(SubjectID),
                      taxaID = taxonomizr::accessionToTaxa(SubjectID,accessionToTaxa_path))


    taxa_call = taxonomizr::getTaxonomy(output$taxaID,accessionToTaxa_path)

    #Returns a data frame containing all of the taxa that were 99% or more identical.

    final = cbind(taxa_call,output) %>%
        dplyr::select(QueryID,superkingdom,phylum,class,
                      order,family,genus,species,Perc.Ident,
                      Mismatches,Alignment.Length) %>%
        dplyr::mutate_if(is.factor,as.character)

    #Here I will loop through the final data frame and collapse it such that only the levels that have unambiguous calls at the level of similarity provided are reported.
    output = matrix(ncol = 7,nrow = 0)
    for(i in unique(final$QueryID)){

        unique = dplyr::filter(final,QueryID == i)
        name = i
        vector = vector()

        for(n in names(unique)[2:8]){
            count = sum(length(table(unique[n])))
            if(count == 1){
                taxa = names(table(unique[n]))
                vector = c(vector,taxa)
            }
            else{
                vector = c(vector,NA)
            }

        }
        output = rbind(output,vector)
    }

    #Making the names pretty
    output = data.frame(output,row.names = NULL)
    names(output) = names(unique)[2:8]

    QueryID = unique(final$QueryID)
    output = cbind(QueryID,output)

    return(output)

}

