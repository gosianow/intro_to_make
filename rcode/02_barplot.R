##############################################################################

# BioC 3.4
# Created 26 Jan 2017
# Updated 26 Jan 2017

##############################################################################
Sys.time()
##############################################################################

# Load packages

##############################################################################
# Test arguments
##############################################################################

rwd='/Users/gosia/Dropbox/my_presentations/Lab_meetings/Code_review/intro_to_make'
outdir='.'
path_file='test1_sum.txt'
prefix='test1_' 
color='blue'

##############################################################################
# Read in the arguments
##############################################################################

rm(list = ls())

args <- (commandArgs(trailingOnly = TRUE))
for (i in 1:length(args)) {
  eval(parse(text = args[[i]]))
}

cat(paste0(args, collapse = "\n"), fill = TRUE)

##############################################################################

setwd(rwd)

if(!file.exists(outdir)) 
  dir.create(outdir, recursive = TRUE)

##############################################################################


x <- read.table(path_file, header = FALSE, sep = "\t", as.is = TRUE)

pdf(file.path(outdir, paste0(prefix, "barplot.pdf")))
barplot(x[, 1], col = color)
dev.off()
























