## CalEnviroScreen Score
output$CES <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT aveCESscore FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('aveCESscore')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"CalEnviroScreen"
    names(data)[2]<-"Score"
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## PM
output$air <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT avgOzone, avgPM25, sumDieselPM FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('avgOzone', 'avgPM25', 'sumDieselPM')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)


## DRINKING WATER
output$water <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT avgDrinkingWater FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('avgDrinkingWater')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

# GROUND
output$ground <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT sumPesticides FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('sumPesticides')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)


### VISUALIZATIONS
output$polutionGauge <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT aveCESscore FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('aveCESscore')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"CalEnviroScreen"
    names(data)[2]<-"Score"
    data[2,1] <- "CES 2.0"
    
    theChart <- gvisGauge(data,
                             labelvar=data[1],
                             numvar=data[2],
                             options = list(
                                 title = paste("Death Breakdown - ", input$demographicZip),
                                 height = '100'),
                             chartid='polutionGauge')
})
