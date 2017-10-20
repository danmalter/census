#' @title Get latidude and longitude
#'
#' @description  Takes in a city/state and outputs the name of the city, latitude and longitude
#' @return Demographic data
#' @importFrom RCurl getURL
#' @importFrom ggmap geocode
#' @examples
#' cities <- c("Chicago", "New York")
#' getLatLon(cities)
#' @export
#'

getLatLon <- function(cities) {
  geo <- ggmap::geocode(cities)
  lat_lon <- data.frame(cbind(cities, geo$lon, geo$lat))
  names(lat_lon)[2] <- "lon"
  names(lat_lon)[3] <- "lat"
  return(lat_lon)
}

#cities <- c("Chicago", "New York")
#getLatLon(cities)
