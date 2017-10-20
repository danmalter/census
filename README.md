# censusapi

[![Build Status](https://travis-ci.org/hrecht/censusapi.svg?branch=master)](https://travis-ci.org/hrecht/censusapi) [![CRAN Badge](https://www.r-pkg.org/badges/version/censusapi)](https://cran.r-project.org/package=censusapi)

`censusR` is a package for getting data from the [Missouri Census Data Center](http://mcdc.missouri.edu/). As of 2017, over 500 data points are available, including population, income, education and employment levels by age and race.

`censusR` relies on the GoogleMaps API for retrieving latitude and longitude coordinates for specified cities.

For more details, see [Getting started with censusR]() and the package's [website]().

## Installation

Install the latest development version of `censusR` from Github using `devtools`:
  ```R
# install.packages("devtools")
devtools::install_github("danmalter/censusR")
```


## Usage examples

Get demographic data for the cities of Chicago and New York. This example only shows some of the over 500 features available.

```R
library(censusR)

# City level data for Chicago and New York
radius <- 2
cities <- c("Chicago", "New York")
getDemographics(cities, radius)

#>      sitename radius   Longitude     Latitude      TotPopSF1   AreaSQMI    LandSQMI  IntPtLat    IntPtLon
#>      Chicago  2        -87.6297982   41.8781136    172,300     10.67397    9.12      41.882238   -87.634391
#>      NewYork  2        -74.0059728   40.7127753    428,961     14.17597    8.45      40.718644   -73.996229
```

If loading city and state information from a csv file, you can just call that column into a list.

```R
radius <- 2
cities <- read_csv("~/path/to/file.csv")
cities <- c(as.character(cities$City_State))
getDemographics(cities, radius)
```

## Disclaimer
This product uses the Google Maps API and collects data from the Missouri Census Data Center, but is not endorsed or certified by Google or the Missouri Census Data Center.
