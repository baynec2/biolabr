Genewiz_16S = function(folder_path,
                      blast_db_path = file.path("/Volumes/kaleidobio/Shared/D2/Departments/Research/Biology/biolabr/16SMicrobial/16SMicrobial"),
                      accessionToTaxa_path = file.path("/Volumes/kaleidobio/Shared/D2/Departments/Research/Biology/biolabr/accessionTaxa.sql"),
                      similarity = 99) {

    folder_path = "/Volumes/kaleidobio/Shared/D2/Projects/Immunoncology (IO)/Discovery/Experiments/01_Akkermansia/01_Isolating_Akkermansia_G878/Genewiz_16S/"
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

