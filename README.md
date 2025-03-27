# Tempetell
This is a Weather station package. It uses your location to get 20 of the nearest weather stations. It provides you with a data-frame and a map of the weather stations. The map has markers for the weather stations with temperature data.

## Overview
**What is the Temperature?** is an R package designed to fetch and display weather station data based on your location. It retrieves information from 20 of the nearest weather stations and provides a data frame along with an interactive map displaying temperature readings.

## Installation
To install the package, first install the required dependencies:

```r
install.packages(c("httr", "jsonlite", "leaflet", "knitr"))
```

Then install the package from GitHub (if hosted there):

```r
# Install devtools if not already installed
install.packages("devtools")

# Install the package
devtools::install_github("yourusername/Tempetell")
```

## Usage

### Load the Library
```r
library(Tempetell)
```

### Get GPS Location
This function retrieves the user's coordinates using the Google API.
```r
gps <- location()
```

### Retrieve Weather Stations
The `PopulateList` function fetches data from a weather API, returning a data frame containing at least 20 nearby weather stations with temperature and humidity data.
```r
stations <- PopulateList(gps)
```

### Display Weather Stations on a Map
The `stationMap` function generates an interactive map using the `leaflet` package. Weather stations are marked, and clicking a marker displays station details, including temperature.
```r
temptell <- stationMap(stations, gps)
temptell
```

## Features
- Fetches 20 nearest weather stations.
- Provides temperature and humidity data in a structured data frame.
- Displays an interactive map with weather station markers.

## Dependencies
This package relies on the following R libraries:
- `httr`
- `jsonlite`
- `leaflet`
- `knitr`

## Disclaimer
This package may generate a warning related to non-ASCII characters in API responses:
```
Found the following file with non-ASCII characters: tempetell.R
Portable packages must use only ASCII characters in their R code, except perhaps in comments.
```
This warning is due to API responses containing non-ASCII characters.

## License
This package is open-source and distributed under the MIT License.

You can view the package vignette [here](https://mikesirya.github.io/Tempetell/vignettes/Weather_package.html)
