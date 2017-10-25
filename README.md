# census

[![Build Status](https://travis-ci.org/danmalter/census.svg?branch=master)](https://travis-ci.org/danmalter/census) [![CRAN Badge](https://www.r-pkg.org/badges/version/census)](https://cran.r-project.org/package=census)

`census` is a package for getting data from the [Missouri Census Data Center](http://mcdc.missouri.edu/). As of 2017, over 500 data points are available, including population, income, education and employment levels by age and race.  Data can only be collected for cities and towns that have a population of 5,000 or more.  An example of the data being collected from Missouri Census Data Center can be seen [here](http://mcdc.missouri.edu/cgi-bin/broker?_PROGRAM=websas.caps10acsb.sas&SERVICE=appdev&sitename=Chicago,IL&longitude=-87.6297982&latitude=41.8781136&radii=2&dprofile=on&eprofile=on&sprofile=on&hprofile=on&cntypops=on&printdetail=on&_debug=).

`census` relies on the GoogleMaps API for retrieving latitude and longitude coordinates for specified cities.  Google Maps allows for 2,500 free requests per day. Note that running a query on any given city too often over too short of a period can result in Google Maps API timeouts.  If this happens, the `getCensus` function will skip that city.  In addition, it is possible that a radius around a small town or city is too small and that there is no data provided by the Missouri Census Data Center. If this is the case, these particular cities will be skipped over as well and a warning message will show.

For more details, see [Getting Started with Census](https://danmalter.github.io/census/articles/getting-started.html) and the package's [website](https://danmalter.github.io/census/index.html).

## Installation

Get the latest stable release from CRAN:

```R
install.packages("census")
```

Install the latest development version of `census` from Github using `devtools`:
```R
# install.packages("devtools")
devtools::install_github("danmalter/census")
```


## Usage examples

This example shows how to retrieve demographic data for the cities of Chicago and New York. This example only shows some of the over 500 features available.  Note that the state is not needed in `getCensus()`, but you can run into problems if the city name appears in multiple states (i.e. Portland, Maine and Portland, Oregon).

```R
library(census)

# City level data for Chicago and New York
radius <- 5
cities <- c("Chicago, IL", "New York")
df <- getCensus(cities, radius)
df[1:2, c("sitename","radius","TotPop","pctMales","pctFemales","AvgFamInc","pctPrivWageWorkers","pctGovWorkers", "pctMarried","pctBachelors","MedianHValue")]

#>  sitename  radius  TotPop      pctMales pctFemales AvgFamInc   pctPrivWageWorkers  pctGovWorkers pctMarried pctBachelors MedianHValue
#>  Chicago   5       756,255     49.3     50.7       $124,825    86.0                9.5           31.9       31.1         $365,867
#>  New York  5       2,269,840   48.6     51.4       $136,510    83.3                9.4           35.9       29.8         $782,702
```

If loading city and state information from a csv file, you can just call that column into a list and run that list in `getCensus()`.

```R
radius <- 2
cities <- read.csv("~/path/to/file.csv")
cities <- c(as.character(cities$City_State))
df <- getCensus(cities, radius)
head(df)
```

To view Google Maps API usage limit. The below function is from the `ggmaps` package.

```R
geocodeQueryCheck() 
```

## Report an issue
If you have issues using, installing, and/or have a question about census, please post a [new issue](https://github.com/danmalter/census/issues).

## Disclaimer
This product uses the Google Maps API and collects data from the Missouri Census Data Center, but is not endorsed or certified by Google or the Missouri Census Data Center.
