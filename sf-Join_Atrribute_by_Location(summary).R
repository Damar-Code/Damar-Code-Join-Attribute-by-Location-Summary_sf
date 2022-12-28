library(sf)


grid <- st_read("//kerapremc01/Geo_Spatial/5.0.Others/Damar/Project/LLP/TPL/QGIS/shp/Grid_Canal AoI.shp")
grid
point <- st_read("//kerapremc01/Geo_Spatial/5.0.Others/Damar/Project/LLP/TPL/QGIS/shp/Point Las_Canal AoI.shp")
point

value_extraction_by_location <- function(feature, point) {
  a <- st_join(point, grid)
  b <- left_join(data.frame(a), data.frame(grid), by="id")
  c <- b %>% 
    select(-"geometry.x") %>%
    group_by(id,geometry.y) %>%
    summarise(maximum = max(FID)) %>%
    as.data.frame() %>%
    st_as_sf()
  return(c)
}
joint = value_extraction_by_location(grid, point)
joint
