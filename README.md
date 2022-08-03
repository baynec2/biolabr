
<!-- README.md is generated from README.Rmd. Please edit that file -->

# biolabr <a href='https://github.com/baynec2/biolabr'><img src='man/hex-biolabr.png' align="right" height="139" /></a>

<!-- badges: start -->
<!-- badges: end -->

The goal of biolabr is to provide a consistent location to store and
access R functions that I have found to be useful for various things in
the laboratory. The functions contained within this package will appear
to be somewhat eclectic, but they will all be intended to provide a
solution for various lab related activities that seem to reoccur and
aren’t complex enough to require a dedicated package on their own.

## Installation

You can install the up to date version of the package from github using
devtools.

``` r
library(devtools)

install_github("baynec2/biolabr")
```

## Functions

### facet_R2

This is a simple function that calculates R2 values for linear models
split by a factor. I find this to be useful for displaying the R2 values
for ggplots with multiple facets.

``` r
library(biolabr)
#> Loading required package: sangeranalyseR
#> Loading required package: stringr
#> Loading required package: ape
#> Warning: package 'ape' was built under R version 4.1.2
#> Loading required package: Biostrings
#> Loading required package: BiocGenerics
#> 
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#> 
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#> 
#>     anyDuplicated, append, as.data.frame, basename, cbind, colnames,
#>     dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
#>     grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
#>     order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
#>     rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
#>     union, unique, unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> Warning: package 'S4Vectors' was built under R version 4.1.3
#> Loading required package: stats4
#> 
#> Attaching package: 'S4Vectors'
#> The following objects are masked from 'package:base':
#> 
#>     expand.grid, I, unname
#> Loading required package: IRanges
#> Loading required package: XVector
#> Loading required package: GenomeInfoDb
#> Warning: package 'GenomeInfoDb' was built under R version 4.1.2
#> 
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:ape':
#> 
#>     complement
#> The following object is masked from 'package:base':
#> 
#>     strsplit
#> Loading required package: DECIPHER
#> Loading required package: RSQLite
#> Loading required package: parallel
#> Loading required package: reshape2
#> Loading required package: phangorn
#> Warning: package 'phangorn' was built under R version 4.1.2
#> Loading required package: sangerseqR
#> Warning: package 'sangerseqR' was built under R version 4.1.3
#> Loading required package: gridExtra
#> 
#> Attaching package: 'gridExtra'
#> The following object is masked from 'package:BiocGenerics':
#> 
#>     combine
#> Loading required package: shiny
#> Warning: package 'shiny' was built under R version 4.1.2
#> Loading required package: shinydashboard
#> 
#> Attaching package: 'shinydashboard'
#> The following object is masked from 'package:graphics':
#> 
#>     box
#> Loading required package: shinyjs
#> 
#> Attaching package: 'shinyjs'
#> The following object is masked from 'package:shiny':
#> 
#>     runExample
#> The following object is masked from 'package:RSQLite':
#> 
#>     show
#> The following object is masked from 'package:Biostrings':
#> 
#>     show
#> The following object is masked from 'package:GenomeInfoDb':
#> 
#>     show
#> The following object is masked from 'package:XVector':
#> 
#>     show
#> The following object is masked from 'package:IRanges':
#> 
#>     show
#> The following object is masked from 'package:S4Vectors':
#> 
#>     show
#> The following object is masked from 'package:stats4':
#> 
#>     show
#> The following objects are masked from 'package:methods':
#> 
#>     removeClass, show
#> Loading required package: data.table
#> 
#> Attaching package: 'data.table'
#> The following objects are masked from 'package:reshape2':
#> 
#>     dcast, melt
#> The following object is masked from 'package:IRanges':
#> 
#>     shift
#> The following objects are masked from 'package:S4Vectors':
#> 
#>     first, second
#> Loading required package: plotly
#> Loading required package: ggplot2
#> Warning: package 'ggplot2' was built under R version 4.1.2
#> 
#> Attaching package: 'plotly'
#> The following object is masked from 'package:ggplot2':
#> 
#>     last_plot
#> The following object is masked from 'package:XVector':
#> 
#>     slice
#> The following object is masked from 'package:IRanges':
#> 
#>     slice
#> The following object is masked from 'package:S4Vectors':
#> 
#>     rename
#> The following object is masked from 'package:stats':
#> 
#>     filter
#> The following object is masked from 'package:graphics':
#> 
#>     layout
#> Loading required package: DT
#> Warning: package 'DT' was built under R version 4.1.2
#> 
#> Attaching package: 'DT'
#> The following objects are masked from 'package:shiny':
#> 
#>     dataTableOutput, renderDataTable
#> Loading required package: zeallot
#> Loading required package: excelR
#> Loading required package: shinycssloaders
#> Loading required package: ggdendro
#> Warning: package 'ggdendro' was built under R version 4.1.2
#> Loading required package: shinyWidgets
#> Warning: package 'shinyWidgets' was built under R version 4.1.2
#> 
#> Attaching package: 'shinyWidgets'
#> The following object is masked from 'package:shinyjs':
#> 
#>     alert
#> Loading required package: openxlsx
#> Loading required package: tools
#> Loading required package: rmarkdown
#> Warning: package 'rmarkdown' was built under R version 4.1.2
#> Loading required package: knitr
#> Warning: package 'knitr' was built under R version 4.1.2
#> Loading required package: seqinr
#> Warning: package 'seqinr' was built under R version 4.1.2
#> 
#> Attaching package: 'seqinr'
#> The following object is masked from 'package:shiny':
#> 
#>     a
#> The following object is masked from 'package:sangerseqR':
#> 
#>     read.abif
#> The following object is masked from 'package:Biostrings':
#> 
#>     translate
#> The following objects are masked from 'package:ape':
#> 
#>     as.alignment, consensus
#> Loading required package: BiocStyle
#> 
#> Attaching package: 'BiocStyle'
#> The following objects are masked from 'package:rmarkdown':
#> 
#>     html_document, md_document, pdf_document
#> The following object is masked from 'package:shiny':
#> 
#>     markdown
#> Loading required package: logger
#> Welcome to sangeranalyseR
#> Loading required package: rBLAST
library(ggplot2)

data(mtcars)

R2 = facet_R2(mtcars,y = "mpg",x = "hp",by = "gear")

p1 = ggplot(mtcars,aes(mpg,hp))+
    geom_point()+
    geom_smooth(method = "lm")+
    facet_grid(~gear)+
    geom_text(data = R2,aes(x = 30, y = 300,label = R2))

p1
#> `geom_smooth()` using formula 'y ~ x'
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

### format_CFU

This function allows the user to parse CFU spot plating data that is
recorded in an excel sheet (found in /template_files/format_CFU/). There
are two types of templates, one for serial dilutions that are made
across plates and another that is used for serial dilutions that are
made row wise.

If you need to add plates to the template, just copy and paste more
copies of the cells representing a plate directly below the previous
ones.

``` r
library(biolabr)

t1 = format_CFU("example_files/CFU_Dilutions_On_Different_Rows_Example.xlsx")
#> New names:
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`
#> • `` -> `...3`
#> • `` -> `...4`
#> • `` -> `...5`
#> • `` -> `...6`
#> • `` -> `...7`
#> • `` -> `...8`
#> • `` -> `...9`
#> • `` -> `...10`
#> • `` -> `...11`
#> • `` -> `...12`
#> • `` -> `...13`
#> • `` -> `...14`
#> • `` -> `...15`
#> • `` -> `...16`
#> • `` -> `...17`
#> • `` -> `...18`

head(t1)
#>   Sample_ID PlateNumber Dilution Media  Condition Length_of_Incubation Well
#> 1   TEST.A1        TEST        3  MTGE    Aerobic                   24   A1
#> 2   TEST.A2        TEST        3  MTGE    Aerobic                   24   A2
#> 3   TEST.A3        TEST        3  MTGE    Aerobic                   24   A3
#> 4   TEST.A4        TEST        2  MTGE    Aerobic                   24   A4
#> 5   TEST.A5        TEST        2  MTGE    Aerobic                   24   A5
#> 6   TEST.A6        TEST        2  MTGE    Aerobic                   24   A6
#>   Colony_Count Dilution_Factor  CFU_mL
#> 1           12            1000 6000000
#> 2           11            1000 5500000
#> 3           10            1000 5000000
#> 4            4             100  200000
#> 5            3             100  150000
#> 6            3             100  150000
```

### Genewiz_16S

This function is useful for programmatically generating consensus
sequences from Genewiz 16S results
(<https://www.genewiz.com/en/Public/Services/Molecular-Genetics/Cell-Line-Authentication>)
and BLASTing them against a database to determine the taxonomy of your
sample.

Unfortunately, this requires the user to have the BLAST+ command line
tools downloaded on their system. Even more unfortunately, this also
requires download of a large sql database (\~26 Gb) that is used to map
the NCBI accession numbers to the actual taxonomy.

Still, I find this beats manually copying and pasting sequences into
BLAST.

First, you need to install BLAST+ on your system. This can be
accomplished by following the instructions below (For Mac OS).

1.  Click the link to download the appropriate installer from
    <https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/>

2.  Double click ncbi-blast-2.4.0+.pkg. If you see the dialog below,
    Hold down the Control key and click ncbi-blast-2.4.0+.pkg. From the
    contextual menu choose Open.

3.  By default the BLAST+ applications will be installed in
    /usr/local/ncbi/blast, overwriting its previous contents (an
    uninstaller is provided and it is recommended when upgrading a
    BLAST+ installation).

Next, you will need to download the 16SMicrobial database

1.  This can be found by going to
    <ftp://ftp.ncbi.nlm.nih.gov/blast/db/v4/>
2.  I like to store this in the same location as the blast files
    (/usr/local/ncbi/blast/db)

Lastly, you will need to install the sql database used to convert the
NCBI_IDs to taxonomy. This can be done by using the [taxonomizer R
package](https://github.com/sherrillmix/taxonomizr)

``` r
## Run this command in the directory that you want to store the database in
setwd("Location you want to download accession database to")
taxomomizer::prepareDatabase('accessionTaxa.sql')
```

Once all of these steps have been completed you should be able to run
the function on your data.

Importantly, this function will return the lowest level of taxonomy that
is completely unambiguous at your specified percent identity. This means
if you specify a percent identity of 99%, and there are matches to
Escherichia coli and Escherichia albertii, the function will only
identify your taxa at the genus level (Escherichia).

``` r
#Note that the file paths specified here are for my machine. Depending on how you set yours up the file paths will differ. 
library(biolabr)
taxonomy = Genewiz_16S(folder_path = "example_files/Genewiz_16S_Data/",
                     blast_db_path = "/usr/local/ncbi/blast/db/16SMicrobial/16SMicrobial",
                     accessionToTaxa_path ="/Volumes/kaleidobio/Shared/D2/Departments/Research/Biology/biolabr/accessionTaxa.sql",
                     similarity = 99)

DT::datatable(taxonomy)
```

Here we can see that all of these isolates named CB011 - CB021 could not
be unambiguously identified beyond order.

### parse_gas_data

This function is useful for parsing data from the Ankom Gas System and
getting it into a tidy format.
(<https://www.ankom.com/product-catalog/ankom-rf-gas-production-system>).

The original output files are in multiple sheets of an excel workbook,
this function consolidates all of this information to a tidy data frame.

``` r
library(biolabr)
df = parse_gas_data("example_files/Ankom_Gas_Data.xls")

head(df)
#> # A tibble: 6 × 6
#>   Time_hr Sample.ID Cumulative_Pressure Absolute_Pressure Temperature Battery_…¹
#>     <dbl> <chr>                   <dbl>             <dbl>       <dbl>      <dbl>
#> 1       0 Reference                14.5              14.5        34.8       6.95
#> 2       0 Sample1                   0                14.4        33.2       6.87
#> 3       0 Sample2                   0                14.4        32.3       6.93
#> 4       0 Sample3                   0                14.4        32.3       6.90
#> 5       0 Sample4                   0                14.4        32.4       6.90
#> 6       0 Sample5                   0                14.4        32.0       6.93
#> # … with abbreviated variable name ¹​Battery_Voltage
```

### rm_leading_0

This function simpily removes leading 0s from Well IDS. For example,
this will change A01 to A1. Some machines in the lab export well IDs
with leading 0s, others do not. As such, this function is frequently
useful for mapping two data sources that have Well IDs in differing
formats.

``` r
library(biolabr)
machine_data_leading_0 = read.csv("example_files/Well_IDs_with_leading_0.csv") 

head(machine_data_leading_0,2)
#>   Well Fluor  End.RFU
#> 1  A01  SYBR 5938.963
#> 2  A02  SYBR 6665.284

machine_data_no_leading_0 = machine_data_leading_0 %>% 
    dplyr::mutate(Well = rm_leading_0(Well))

head(machine_data_no_leading_0,2)
#>   Well Fluor  End.RFU
#> 1   A1  SYBR 5938.963
#> 2   A2  SYBR 6665.284
```

## assign_gel_wells

This function is useful for assigning Well IDs to DNA bands that have
been run through gel electrophoresis, and then detected using the open
source GelAnalyzer software (<http://www.gelanalyzer.com/>).

This function assumes that samples have been loaded onto the gel using a
multichannel pipette following a specific pattern. One single large gel
can accommodate up to 2 x 96 well plates. This is displayed visually
below:

![](img/96_gel_diagram.jpeg)

``` r
d1 = assign_gel_wells("example_files/Gel_Band_Data.xlsx")

DT::datatable(d1)
#> PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
```

<div id="htmlwidget-bc2f2ed6c8cac2465db7" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bc2f2ed6c8cac2465db7">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248","249","250","251","252","253","254","255","256","257","258","259"],["E1","E1","E1","F1","F1","F1","E2","E2","E2","F2","F2","F2","E3","E3","E3","F3","F3","F3","E4","E4","E4","F4","F4","F4","E5","E5","E5","F5","F5","F5","E6","E6","E6","F6","F6","F6","E7","E7","E7","F7","F7","F7","E8","E8","E8","E8","F8","F8","F8","F8","E9","E9","E9","E9","F9","F9","F9","F9","E10","E10","E10","E10","F10","F10","F10","F10","E11","E11","F11","F11","F11","F11","E12","E12","E12","E12","E12","F12","F12","F12","F12","G1","G1","G1","G1","H1","H1","H1","G2","G2","G2","G2","G2","H2","H2","H2","H2","H2","G3","G3","G3","G3","G3","H3","H3","H3","H3","H3","G4","G4","G4","G4","H4","H4","H4","H4","H4","G5","G5","G5","G5","G5","H5","H5","H5","H5","G6","G6","G6","G6","H6","H6","H6","G7","G7","G7","G7","G7","H7","H7","H7","G8","G8","G8","G8","H8","H8","G9","G9","G9","H9","G10","G10","H10","G11","G11","H11","G12","G12","H12","H12","A1","A1","B1","B1","A2","A2","B2","B2","A3","A3","B3","B3","A4","A4","B4","B4","A5","A5","B5","B5","A6","A6","B6","B6","A7","A7","B7","B7","A8","A8","B8","B8","B8","B8","A9","A9","B9","B9","A10","A10","B10","B10","A11","A11","A11","B11","B11","A12","A12","B12","B12","C1","C1","D1","D1","C2","C2","D2","D2","D2","C3","C3","D3","D3","C4","C4","D4","D4","C5","C5","D5","D5","C6","C6","D6","D6","C7","C7","D7","D7","C8","C8","D8","D8","C9","C9","D9","D9","C10","C10","D10","D10","C11","C11","D11","D11","C12","C12"],[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[5147,2573,1537,5059,2494,1516,5059,2494,1516,4973,2417,1496,4973,2417,1496,4973,2380,1476,4889,2380,1476,4806,2344,1496,4806,2417,1516,4725,2344,1456,4725,2308,1418,4645,2273,1399,4645,2273,1399,4566,2273,1381,14682,4566,2273,1381,14418,4566,2273,1381,14682,4566,2239,1381,14418,4566,2239,1399,14158,4490,2239,1381,14158,4566,2239,1399,2205,1346,13903,4414,2205,1363,16377,14158,4490,2205,1363,13903,4414,2205,1363,13903,4340,2205,1346,4340,2172,1328,16377,13654,4267,2139,1328,15791,13408,4267,2139,1328,15791,13654,4267,2139,1312,16081,13408,4267,2139,1328,9187,4267,2139,1312,13167,8865,4196,2107,1312,15506,9025,4196,2076,1295,12931,8709,2076,1279,8865,4057,2045,1263,8404,2015,1263,12699,8865,3990,1985,1247,13167,1985,1247,14951,13167,11191,1985,1956,1263,8555,2107,1247,2107,8555,2076,1928,1845,1159,1845,1845,1159,1872,1173,2443,1468,2363,1448,2324,1409,2286,1409,2286,1389,2324,1389,2286,1389,2286,1353,2212,1335,2176,1300,2141,1283,2141,1300,2107,1283,2107,1267,2073,1267,18525,11858,2073,1267,2073,1251,2073,1251,2041,1235,2041,1220,11165,2008,1220,2008,1220,2008,1220,1977,1205,1977,1205,1946,1190,1946,1190,16392,1916,1175,1916,1190,1886,1161,1886,1161,1857,1161,1857,1161,1829,1147,1801,1134,1774,1134,1774,1134,1748,1120,1748,1120,1748,1120,1748,1120,1748,1120,1748,1120,1748,1094,1721,1120,1748,1094,1748,1094],[0.264,0.425,0.559,0.268,0.433,0.563,0.268,0.433,0.563,0.272,0.441,0.567,0.272,0.441,0.567,0.272,0.444,0.571,0.276,0.444,0.571,0.28,0.448,0.567,0.28,0.441,0.563,0.284,0.448,0.575,0.284,0.452,0.582,0.287,0.456,0.586,0.287,0.456,0.586,0.291,0.456,0.59,0.038,0.291,0.456,0.59,0.042,0.291,0.456,0.59,0.038,0.291,0.46,0.59,0.042,0.291,0.46,0.586,0.046,0.295,0.46,0.59,0.046,0.291,0.46,0.586,0.464,0.598,0.05,0.299,0.464,0.594,0.015,0.046,0.295,0.464,0.594,0.05,0.299,0.464,0.594,0.05,0.303,0.464,0.598,0.303,0.467,0.602,0.015,0.054,0.307,0.471,0.602,0.023,0.057,0.307,0.471,0.602,0.023,0.054,0.307,0.471,0.605,0.019,0.057,0.307,0.471,0.602,0.138,0.307,0.471,0.605,0.061,0.146,0.31,0.475,0.605,0.027,0.142,0.31,0.479,0.609,0.065,0.149,0.479,0.613,0.146,0.318,0.483,0.617,0.157,0.487,0.617,0.069,0.146,0.322,0.49,0.621,0.061,0.49,0.621,0.034,0.061,0.096,0.49,0.494,0.617,0.153,0.475,0.621,0.475,0.153,0.479,0.498,0.51,0.644,0.51,0.51,0.644,0.506,0.64,0.471,0.607,0.479,0.612,0.483,0.62,0.488,0.62,0.488,0.624,0.483,0.624,0.488,0.624,0.488,0.632,0.496,0.636,0.5,0.645,0.504,0.649,0.504,0.645,0.508,0.649,0.508,0.653,0.512,0.653,0.033,0.124,0.512,0.653,0.512,0.657,0.512,0.657,0.517,0.661,0.517,0.665,0.136,0.521,0.665,0.521,0.665,0.521,0.665,0.525,0.669,0.525,0.669,0.529,0.674,0.529,0.674,0.058,0.533,0.678,0.533,0.674,0.537,0.682,0.537,0.682,0.541,0.682,0.541,0.682,0.545,0.686,0.55,0.69,0.554,0.69,0.554,0.69,0.558,0.694,0.558,0.694,0.558,0.694,0.558,0.694,0.558,0.694,0.558,0.694,0.558,0.702,0.562,0.694,0.558,0.702,0.558,0.702],[551,1761,1243,626,2042,1486,519,1901,1325,542,2299,1420,596,2365,1529,599,2627,1466,600,2277,1371,541,2363,1550,553,2952,1645,552,2558,1393,505,2474,1393,568,2589,1440,647,2340,1350,596,2608,1538,552,546,2326,1407,615,619,2613,1529,616,625,2613,1440,704,624,2924,1509,639,571,2598,1608,577,713,3139,1854,2775,947,655,637,2929,1525,616,669,629,2311,1375,736,639,2466,1441,1489,660,2578,1539,711,2613,1536,678,660,648,2660,1466,722,656,634,2680,1627,774,713,640,2356,1420,667,1231,701,2534,1461,1026,705,2428,1472,654,1041,734,2803,1679,1794,1233,776,3679,1993,663,4074,3454,1915,1009,594,2076,1216,3936,2423,1465,577,855,651,2171,1161,1207,2496,1414,564,545,651,2146,2427,1346,766,1522,778,1142,623,1127,1774,1148,722,895,1636,865,1476,848,1055,950,893,830,1213,1132,1240,1083,1512,1144,1364,1012,1430,1322,1431,1172,1778,1387,1584,1337,1822,1474,1614,1306,1945,1477,1963,1465,1966,1583,551,576,1771,1376,1853,1516,1885,1199,2016,1531,1838,1389,591,1944,1569,1857,1665,1892,1637,1930,1598,2065,1522,1923,1386,2037,1616,1251,1892,1649,2249,1714,1888,1615,1900,1524,2083,1514,1901,1368,1859,1480,1753,1371,1844,1414,1622,1330,1756,1377,1776,1402,1745,1331,1682,1298,1661,1159,1656,1364,1228,1014,1436,1146,1385,1055,1309,1014],[145.464,748.425,694.837,167.768,884.186,836.618,139.092,823.133,745.975,147.424,1013.859,805.14,162.112,1042.965,866.943,162.928,1166.388,837.086,165.6,1010.988,782.841,151.48,1058.624,878.85,154.84,1301.832,926.135,156.768,1145.984,800.975,143.42,1118.248,810.726,163.016,1180.584,843.84,185.689,1067.04,791.1,173.436,1189.248,907.42,20.976,158.886,1060.656,830.13,25.83,180.129,1191.528,902.11,23.408,181.875,1201.98,849.6,29.568,181.584,1345.04,884.274,29.394,168.445,1195.08,948.72,26.542,207.483,1443.94,1086.444,1287.6,566.306,32.75,190.463,1359.056,905.85,9.24,30.774,185.555,1072.304,816.75,36.8,191.061,1144.224,855.954,74.45,199.98,1196.192,920.322,215.433,1220.271,924.672,10.17,35.64,198.936,1252.86,882.532,16.606,37.392,194.638,1262.28,979.454,17.802,38.502,196.48,1109.676,859.1,12.673,70.167,215.207,1193.514,879.522,141.588,216.435,1143.588,890.56,39.894,151.986,227.54,1331.425,1015.795,48.438,175.086,240.56,1762.241,1213.737,43.095,607.026,1654.466,1173.895,147.314,188.892,1002.708,750.272,617.952,1180.001,903.905,39.813,124.83,209.622,1063.79,720.981,73.627,1223.04,878.094,19.176,33.245,62.496,1051.54,1198.938,830.482,117.198,722.95,483.138,542.45,95.319,539.833,883.452,585.48,464.968,456.45,834.36,557.06,746.856,542.72,496.905,576.65,427.747,507.96,585.879,701.84,605.12,671.46,737.856,713.856,658.812,631.488,697.84,824.928,698.328,740.704,881.888,882.132,792,862.365,918.288,956.626,813.456,842.37,988.06,958.573,997.204,956.645,1006.592,1033.699,18.183,71.424,906.752,898.528,948.736,996.012,965.12,787.743,1042.272,1011.991,950.246,923.685,80.376,1012.824,1043.385,967.497,1107.225,985.732,1088.605,1013.25,1069.062,1084.125,1018.218,1017.267,934.164,1077.573,1089.184,72.558,1008.436,1118.022,1198.717,1155.236,1013.856,1101.43,1020.3,1039.368,1126.903,1032.548,1028.441,932.976,1013.155,1015.28,964.15,945.99,1021.576,975.66,898.588,917.7,979.848,955.638,991.008,972.988,973.71,923.714,938.556,900.812,926.838,804.346,924.048,946.616,685.224,711.828,807.032,795.324,772.83,740.61,730.422,711.828]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Well_ID<\/th>\n      <th>Gel_Section<\/th>\n      <th>Band_MW<\/th>\n      <th>Rf<\/th>\n      <th>Raw volume<\/th>\n      <th>intensity<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### %nin%

This is an operator for negated value matching. I frequently find it
useful to have an operator that is the opposite of %in%. This operator
returns FALSE if a match is present, TRUE if a match is not present.

``` r
test = c(1,1,1,1,1,2,1,1,1,1)

test %nin% 2
#>  [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE
```

### Dynamic Time Warping

This package also contains functions designed to make it easy to do
dynamic time warping in order to look through high dimensional datasets
for features that match a given pattern of interest.

Here in this example we will be looking at an untargeted metabalomic
data set of a timeseries of unique IDs described as a m/z at a given
retention time. The time series includes a measurement at 0, 4.00, 8.03,
, and 39.44 hrs.

First let’s generate a hypothetical pattern of interest and bind it to
our data set

``` r
# Pattern of interest starts out high then rapidly decreases after ~4 hrs. 
POI = data.frame(POI = c(100000,80000,1000,0,0,0))

mb = readr::read_csv("example_files/Metabolomic_Time_Series.csv")
#> Rows: 6 Columns: 1515
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> dbl (1515): M165T356, M234T171, M177T411, M468T203, M380T447, M313T199, M518...
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

all = cbind(mb,POI)
```

Now let’s apply the dynamic time warping algorithm to generate a
distance matrix.

``` r
#Note that this function scales the data within each time series by default. 
dist = biolabr::dtwarper(all)
saveRDS(dist,"example_files/dist.rds")
```

``` r
#reading from file to save time. 
dist = readRDS("example_files/dist.rds")
```

Note that this function takes a while to run as dynamic time warping is
somewhat computationally intense.

Now we can pull out the 10 features that match this pattern the best.

``` r
n_IDs = find_n_similar(dist,"POI", n = 10)
```

Let’s plot these IDs so we can see what the trends look like.

``` r
library(ggplot2)

# First need to convert the format back to long so we can plot these easily
Time = tibble::tibble(Time = c(0,4,8.03,22.43,25.43,29.43))

# Filtering to keep the 10 closest matches
long = cbind(Time,all) %>% 
  tidyr::pivot_longer(2:length(.)) %>% 
  dplyr::filter(name %in% c(n_IDs,"POI"))

# Plotting
p1 = long %>% 
  ggplot(aes(Time,value,color = name))+
  geom_point()+
  geom_line()+
  facet_wrap(~name,scales = "free_y")+
  theme(legend.position = "none")+
  ggtitle("10 Most Similar Features to POI by Dynamic Time Warping")

p1
```

<img src="man/figures/README-unnamed-chunk-15-1.png" width="100%" />
Here we can see that this seems to have worked fairly well! We are able
to see trends that are pretty close to matching the POI that we entered.

### RMD Template

This package also contains a simple template that can be used for RMD
analysis files called Kaleido Analysis.
