## ---- echo = FALSE-------------------------------------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(purl = NOT_CRAN)

## ---- warning=FALSE, message=FALSE---------------------------------------
library(census)

# City level data for Chicago and New York
radius <- 2
cities <- c("Chicago, IL", "New York")
df <- getCensus(cities, radius)
df[1:2, c(1:2,12,55,59,164,252,254,305,336,477)]

