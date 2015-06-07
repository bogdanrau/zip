output$myMap <- renderLeaflet({
    input$getData
#     mapData <- isolate(dbGetQuery(connection, paste0("SELECT zip, BMA_20 FROM data")))
    latlon <- geocode(as.character(input$demographicZip))

    leaflet() %>% addProviderTiles("Stamen.TonerLite", options = providerTileOptions(noWrap = TRUE)) %>% setView(latlon$lon, latlon$lat, zoom = 10)
})