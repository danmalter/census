#' @title Scrape US Census Data
#'
#' @description Takes in a city/state and outputs demographic data from the Missouri Census Data Center
#' @param cities list of cities to be passed
#' @param radius numeric number used to create a boundary around the city coordinates
#' @return Data frame containing demographic data
#' @importFrom RCurl getURL
#' @importFrom ggmap geocode
#' @importFrom utils read.csv
#' @importFrom stats na.omit
#' @examples
#' radius <- 5
#' cities <- c("Boston", "Los Angeles")
#' df <- getCensus(cities, radius)
#' head(df)
#' @export
#'

getCensus <- function(cities, radius) {
  geo.reply <- ggmap::geocode(cities, output='more', override_limit=TRUE)
  geo.df <- geo.reply[,c("locality", "lon", "lat")]
  geo.df <- na.omit(geo.df) #exclude if over Google query limit for that city
  
  # Remove spaces between city names and replace with a + sign for URL purposes.  Example "New York" to "New+York".
  cities.lst <- list(geo.df$locality)
  for (i in 1:length(cities.lst)){
    cities.lst <- gsub("[[:space:]]", "+", cities.lst[[i]])
  }
  
  lon.lst <- unlist(as.character(geo.df$lon))
  lat.lst <- unlist(as.character(geo.df$lat))
  
  url <- list()
  url <- as.list(paste("http://mcdc.missouri.edu/cgi-bin/broker",
                       "?_PROGRAM=websas.caps10acsb.sas&SERVICE=appdev",
                       "&sitename=", cities.lst,
                       "&longitude=", lon.lst,
                       "&latitude=", lat.lst,
                       "&radii=", radius,
                       "&dprofile=on&eprofile=on&sprofile=on&hprofile=on",
                       "&cntypops=on&printdetail=on&_debug=",
                       sep=""))
  #print(url)
  
  result = list()
  for (i in 1:length(url)){
    html <- RCurl::getURL(url[[i]])
    pattern <- "href=\"/tmpscratch/caps10acs(.*?).csv\""
    match.info <- regexec(pattern=pattern, text=html)
    num.start <- match.info[[1]][2]
    num.length <- attr(match.info[[1]], "match.length")[2]
    num <- substr(html, num.start, num.start + num.length - 1)
    file.location <- paste("http://mcdc.missouri.edu/tmpscratch/",
                           "caps10acs", num, ".csv",
                           sep="")
    
    # skip if problem with URL - Example bad URL: http://mcdc.missouri.edu/tmpscratch/caps10acsNA.csv
    if (grepl("NA", file.location) == "TRUE"){
      warning('URL failed: ', url[i]) 
      next
    } else {
      data.tmp <- data.frame(read.csv(file=file.location, colClasses = "character"))
      result[[i]] <- data.tmp
    }
  }
  
  final.result <- do.call(rbind, result)
  return(final.result)
}

### Example ###
#radius <- 5
#cities <- c("Chicago", "New York")
#df <- getCensus(cities, radius)
#head(df)
