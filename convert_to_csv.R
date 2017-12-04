# Copyright (R) Paulo Urio
# Do whatever you want with this code, I don’t care.
library("bit64")
library("data.table")
library("descr")

# Reads a raw IBGE input |data.fname| and converts it to CSV |output.fname|,
# adding the columns according to the feature dictionary |dict.fname|.
#
# Parameters:
#   data.fname: a FWF file obtaing from IBGE [1]
#   dict.fname: a CSV file with the first file columns of the IBGE’s feature
#               dictionary (also availabe at [1]).  If you need to generate,
#               just copy the first five columns and add this header:
#               "initial_pos,size,code,number,description"
#               See a examples in data/dict/*.csv
#   output.fname: the path for the resulting CSV file
#
# [1] Source of datasets: ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/
# Pesquisa_Nacional_por_Amostra_de_Domicilios_anual/microdados/2015/
ibge_to_csv <- function(data.fname, dict.fname, output.fname)
{
    cat(sprintf("Reading dictionary '%s'\n", dict.fname))
    dict <- read.csv(file = dict.fname, header = TRUE)
    dict <- dict[, -which(names(dict) == "number")]
    dict <- dict[complete.cases(dict), ]
    dict$initial_pos <- as.integer(dict$initial_pos)
    dict$size <- as.integer(dict$size)

    final_pos <- dict$initial_pos + dict$size - 1

    cat(sprintf("Writing CSV '%s'\n", output.fname))
    fwf2csv(fwffile = data.fname,
            csvfile = output.fname,
            names = dict$code,
            begin = dict$initial_pos,
            end = final_pos)
}

ibge_to_csv(
    data.fname = "data/raw/DOM2015.txt",
    dict.fname = "data/dict/homes.csv",
    output.fname = "data/dom2015.csv")


ibge_to_csv(
    data.fname = "data/raw/PES2015.txt",
    dict.fname = "data/dict/people.csv",
    output.fname = "data/pes2015.csv")
