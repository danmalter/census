# censusapi

[![Build Status](https://travis-ci.org/hrecht/censusapi.svg?branch=master)](https://travis-ci.org/hrecht/censusapi) [![CRAN Badge](https://www.r-pkg.org/badges/version/censusapi)](https://cran.r-project.org/package=censusapi)

`censusR` is a package for getting data from the [Missouri Census Data Center](http://mcdc.missouri.edu/). As of 2017, over 500 data points are available, including population, income, education and employment levels by age and race. 

`censusR` relies on the GoogleMaps API for retrieving latitude and longitude coordinates for specified cities.  Google Maps allows for 2500 free requests per day.  If running the same city too often, the Google Maps API may ignore that particular request.

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
cities <- c("Chicago, IL", "New York") # note: state is not needed, but can result in incorrect information if city name is in multiple states
df <- getDemographics(cities, radius)
df[1:2, c(1:2,12,55,59,164,252,254,305,336,477)]

#>  sitename  radius  TotPop    pctMales pctFemales AvgFamInc   pctPrivWageWorkers  pctGovWorkers pctMarried pctBachelors MedianHValue
#>  Chicago   2       188,040   48.0     52.0       $192,455    86.7                9.0           35.3       38.9         $430,285
#>  NewYork   2       444,373   49.2     50.8       $189,738    84.9                7.2           35.5       36.4         $1009199
```

If loading city and state information from a csv file, you can just call that column into a list.

```R
library(readr)
radius <- 2
cities <- read_csv("~/path/to/file.csv")
cities <- c(as.character(cities$City_State))
df <- getDemographics(cities, radius)
head(df)
```

## Disclaimer
This product uses the Google Maps API and collects data from the Missouri Census Data Center, but is not endorsed or certified by Google or the Missouri Census Data Center.
