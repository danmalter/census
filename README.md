# census

[![Build Status](https://travis-ci.org/danmalter/census.svg?branch=master)](https://travis-ci.org/danmalter/census)

`census` is a package for getting data from the [Missouri Census Data Center](http://mcdc.missouri.edu/). As of 2017, over 500 data points are available, including population, income, education and employment levels by age and race.  Cities and towns must have a population of 5,000 or more.  An example of the data being collected from Missouri Census Data Center can be seen [here](http://mcdc.missouri.edu/cgi-bin/broker?_PROGRAM=websas.caps10acsb.sas&SERVICE=appdev&sitename=Chicago,IL&longitude=-87.6297982&latitude=41.8781136&radii=2&dprofile=on&eprofile=on&sprofile=on&hprofile=on&cntypops=on&printdetail=on&_debug=).

`census` relies on the GoogleMaps API for retrieving latitude and longitude coordinates for specified cities.  Google Maps allows for 2500 free requests per day.  If running the same city too often, the Google Maps API may ignore that particular request.

For more details, see [Getting started with census](https://danmalter.github.io/census/articles/getting-started.html) and the package's [website](https://danmalter.github.io/census/).

## Installation

Install the latest development version of `census` from Github using `devtools`:
```R
# install.packages("devtools")
devtools::install_github("danmalter/census")
```


## Usage examples

Get demographic data for the cities of Chicago and New York. This example only shows some of the over 500 features available.  Note that the state is not needed in `getCensus()`, but it can run into problems if the city name appears in multiple states.

```R
library(census)

# City level data for Chicago and New York
radius <- 2
cities <- c("Chicago, IL", "New York")
df <- getCensus(cities, radius)
df[1:2, c(1:2,12,55,59,164,252,254,305,336,477)]

#>  sitename  radius  TotPop    pctMales pctFemales AvgFamInc   pctPrivWageWorkers  pctGovWorkers pctMarried pctBachelors MedianHValue
#>  Chicago   2       188,040   48.0     52.0       $192,455    86.7                9.0           35.3       38.9         $430,285
#>  NewYork   2       444,373   49.2     50.8       $189,738    84.9                7.2           35.5       36.4         $1009199
```

If loading city and state information from a csv file, you can just call that column into a list.

```R
radius <- 2
cities <- read.csv("~/path/to/file.csv")
cities <- c(as.character(cities$City_State))
df <- getCensus(cities, radius)
head(df)
```

To view Google Maps API usage limit. The below function is from the ggmaps package.

```R
geocodeQueryCheck() 
```

## Report an issue
If you having issues using, installing, and/or have a question about census, please post a [new issue](https://github.com/danmalter/census/issues)

## Disclaimer
This product uses the Google Maps API and collects data from the Missouri Census Data Center, but is not endorsed or certified by Google or the Missouri Census Data Center.
