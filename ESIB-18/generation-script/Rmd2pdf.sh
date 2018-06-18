#! /usr/bin/Rscript --vanilla --default-packages=base,stats,utils
# should write in Rmd
library(knitr)
library(rmarkdown)
#rmarkdown::render('../optimisation/intro-optimisation.Rmd')
rmarkdown::render('../4-optimisation-mathématique/flow-optimisation.Rmd')
