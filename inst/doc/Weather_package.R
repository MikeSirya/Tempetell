## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(Tempetell)

## -----------------------------------------------------------------------------
location <- function() {
  Google_Key <- "AIzaSyA-8CTDisLXo_SLzKRQMv7ds4porl_cq9Q"
  url <- paste0("https://www.googleapis.com/geolocation/v1/geolocate?key=", Google_Key)
  response <-httr::POST(url)
  print(response)


  if (httr::http_type(response) == "application/json") {
    success <- httr::content(response, "parsed")
    lat<-success$location$lat
    lng<-success$location$lng
  }
  print (lat, lng)
  return(c(lat,lng))
}
gps<- location()

## -----------------------------------------------------------------------------
PopulateList <- function(gps) {
  key <- "8c8a482f0c519bcc56bf79715ea71154"
  service_url <- "https://api.openweathermap.org/data/2.5/find?"

  url <- paste0(service_url, "appid=", key, "&lat=", gps[1], "&lon=", gps[2], "&cnt=20&units=metric")
  print(url)

  data <- httr::GET(url)

  if (httr::status_code(data) == 200) {
    datacontent <- httr::content(data, as = "text")
    dataJSON <- jsonlite::fromJSON(datacontent, simplifyVector = FALSE)

    result_list <- list()

    for (i in seq_along(dataJSON$list)) {
      city_id <- dataJSON$list[[i]]$id
      city_name <- dataJSON$list[[i]]$name
      coordinates <- dataJSON$list[[i]]$coord
      temperature <- dataJSON$list[[i]]$main$temp
      humidity <- dataJSON$list[[i]]$main$humidity


      result_df <- data.frame(city_id = city_id, city_name = city_name, latitude = coordinates$lat,
                              longitude = coordinates$lon, temperature = temperature, humidity = humidity)


      result_list[[i]] <- result_df
    }


    result_df <- do.call(rbind, result_list)

    print( result_df)

    return(result_df)
  } else {
    print("Error: Failed to retrieve data from the API.")
    return(NULL)
  }
}
stations <- PopulateList(gps)

## -----------------------------------------------------------------------------
stationMap <- function(stations,gps) {
  map <- leaflet::leaflet()
  map <- leaflet::addTiles(map)  # This adds a default OSM web map
  map <- leaflet::setView(map, lng = gps[2], lat = gps[1], zoom = 10)  # This sets initial map view to the coordinates of user location


  for (i in seq_len(nrow(stations))) {
    city_name <- stations$city_name[i]
    coordinates <- c(stations$longitude[i], stations$latitude[i])
    temperature <- stations$temperature[i]

    popup_message <- paste("Station:", city_name, "<br>",
                           "Temperature:", temperature, "°C")

    map <- leaflet::addMarkers(map, lng = coordinates[1], lat = coordinates[2],
                               popup = popup_message)
  }

  return(map)
}
temptell <- stationMap(stations,gps)
temptell

