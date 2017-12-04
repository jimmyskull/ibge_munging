library("bit64")
library("data.table")
library("descr")

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
