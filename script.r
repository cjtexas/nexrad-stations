library(magrittr)
library(rvest)
library(sf)
library(xml2)

"https://mesonet.agron.iastate.edu/sites/networks.php?network=NEXRAD&format=html" %>% 
  xml2::read_html() %>% 
  rvest::html_table() %>% 
  .[2] %>% 
  as.data.frame() %>% 
  .[, 1:5] %>% 
  magrittr::set_colnames(c("nexrad_id", "nexrad_name", "latitude", "longitude", "elevation_m")) %>% 
  sf::st_as_sf(coords = c("longitude", "latitude"), crs = 4326) %>% 
  sf::st_write(dsn = "nexrad-stations.geojson", delete_dsn = TRUE)
