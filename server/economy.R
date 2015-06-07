output$business <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT employeeEstablisment, payrollEmployee FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('employeeEstablisment', 'payrollEmployee')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    data[1,2] <- format(round(data[1,2], digits=0), big.mark=",")
    data[1,2] <- paste0("$",data[1,2])
    data[2,2] <- round(as.numeric(data[2,2], digits=0))
    data[2,2] <- format(data[2,2], big.mark=",")
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## TAXES
output$taxes <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT retper, taxper FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('retper', 'taxper')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    data[1,2] <- format(round(as.numeric(data[1,2]), digits=0), big.mark=",")
    data[1,2] <- paste0("$",data[1,2])
    data[2,2] <- format(round(as.numeric(data[2,2]), digits=0), big.mark=",")
    data[2,2] <- paste0("$",data[2,2])
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## HOUSING
output$zillow <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT MarketHealthIndex, mediansoldprice, PctofHomesDecreasingInValue FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('MarketHealthIndex', 'mediansoldprice', 'PctofHomesDecreasingInValue')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    data[1,2] <- round(data[1,2], digits=0)
    data[1,2] <- format(data[1,2], big.mark=",")
    data[1,2] <- paste0("$", data[1,2])
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

output$medianRent <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT MedianRent FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('MedianRent')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    data[1,2] <- round(data[1,2], digits=0)
    data[1,2] <- format(data[1,2], big.mark=",")
    data[1,2] <- paste0("$", data[1,2])
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

output$rentown <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT Renter, Owner FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('Renter', 'Owner')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Measure"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)*100
    data[1,2] <- round(data[1,2], digits=0)
    data[1,2] <- format(data[1,2], big.mark=",")
    data[2,2] <- round(as.numeric(data[2,2]), digits=0)
    data[2,2] <- format(data[2,2], big.mark=",")
    data$Percent <- round(data$Percent, digits=2)
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## INCOME INEQUALITY
output$income_inequality <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT GINI FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('GINI')
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

