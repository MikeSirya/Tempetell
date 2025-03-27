test_that("location function makes a successful Google API POST request", {
  # Run the location function
  coords <- location()

  # Check if the coords variable contains valid latitude and longitude
  expect_true(is.numeric(coords))
  expect_length(coords, 2)
  expect_true(all(coords >= -90 & coords <= 90))  # Check if latitudes and longitudes are within valid ranges

  # Check if the Google API POST request was successful (status code 200)
  url <- "https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyA-8CTDisLXo_SLzKRQMv7ds4porl_cq9Q"
  response <- httr::POST(url)

  # Check if the status code is 200 (OK)
  expect_equal(httr::status_code(response), 200)
})
