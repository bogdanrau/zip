output$myMap <- renderLeaflet({
    input$getData
#     mapData <- isolate(dbGetQuery(connection, paste0("SELECT zip, BMA_20 FROM data")))
    
    
    latlon <- geocode(as.character(input$demographicZip))
    
    
    pal <- colorQuantile("YlGn", NULL, n = 5)
    popup <- paste0("<strong>Zip: </strong>", 
                          data$zip, 
                          "<br><strong>BMA_20: </strong>", 
                          data$BMA_20)
    

    
    m = leaflet() %>% addProviderTiles("Stamen.TonerLite", options = providerTileOptions(noWrap = TRUE)) %>% setView(latlon$lon, latlon$lat, zoom = 10)
})