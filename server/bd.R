## BIRTH BY MOTHER'S AGE
output$birth_age <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT BMA_20, BMA_2029, BMA_3034, BMA_35, BMA_UNK FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('BMA_20', 'BMA_2029', 'BMA_3034', 'BMA_35', 'BMA_UNK')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Mother's Age"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    data$Estimate <- format(data$Estimate, big.mark=",")
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## BIRTH BY RACE
output$birth_race <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT BR_AmInd, BR_Asian, BR_Black, BR_Filipino, BR_Hispanic, 
                                                        BR_HwPac, BR_Other, BR_SE, BR_Two, BR_White FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('BR_AmInd', 'BR_Asian', 'BR_Black', 'BR_Filipino', 'BR_Hispanic', 
                                                        'BR_HwPac', 'BR_Other', 'BR_SE', 'BR_Two', 'BR_White')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Race"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    data$Estimate <- format(data$Estimate, big.mark=",")
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## LOW BIRTH WEIGHT
output$birth_weight <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT BW_1499, BW_15002499, BW_2500, BW_UNK FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('BW_1499', 'BW_15002499', 'BW_2500', 'BW_UNK')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Birth Weight"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    data$Estimate <- format(data$Estimate, big.mark=",")
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## PRENATAL CARE
output$prenatal_care <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT PC_FIRST, PC_NONE, PC_SECOND, PC_THIRD, PC_UNKNOWN FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column,label FROM metadata WHERE var_column IN('PC_FIRST', 'PC_NONE', 'PC_SECOND', 'PC_THIRD', 'PC_UNKNOWN')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Prenatal Care"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    data$Estimate <- format(data$Estimate, big.mark=",")
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## DEATHS
output$deaths <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT ALZ, CAN, CLD, DIA, HOM, HTD, HYP, INJ, LIV, OTH, PNF, STK, SUI FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column,label FROM metadata WHERE var_column IN('ALZ', 'CAN', 'CLD', 'DIA', 'HOM', 'HTD', 'HYP', 'INJ', 'LIV', 'OTH', 'PNF', 'STK', 'SUI')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Cause of Death"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    data$Estimate <- format(data$Estimate, big.mark=",")
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)



### VISUALIZATIONS
output$babyAgeChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT BR_AmInd, BR_Asian, BR_Black, BR_Filipino, BR_Hispanic, 
                                                  BR_HwPac, BR_Other, BR_SE, BR_Two, BR_White FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('BR_AmInd', 'BR_Asian', 'BR_Black', 'BR_Filipino', 'BR_Hispanic', 
                                                      'BR_HwPac', 'BR_Other', 'BR_SE', 'BR_Two', 'BR_White')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Race"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    
    theChart <- gvisPieChart(data,
                             labelvar=data[1],
                             numvar=data[3],
                             options = list(
                                 title = paste("Birth by Mother's Age - ", input$demographicZip),
                                 height = '300'),
                             chartid='babyAgeChart')
})

output$babyRaceChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT BR_AmInd, BR_Asian, BR_Black, BR_Filipino, BR_Hispanic, 
                                                        BR_HwPac, BR_Other, BR_SE, BR_Two, BR_White FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('BR_AmInd', 'BR_Asian', 'BR_Black', 'BR_Filipino', 'BR_Hispanic', 
                                                        'BR_HwPac', 'BR_Other', 'BR_SE', 'BR_Two', 'BR_White')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Race"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    
    theChart <- gvisPieChart(data,
                             labelvar=data[1],
                             numvar=data[3],
                             options = list(
                                 title = paste("Birth by Race - ", input$demographicZip),
                                 height = '400'),
                             chartid='babyRaceChart')
})

output$weightChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT BW_1499, BW_15002499, BW_2500, BW_UNK FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('BW_1499', 'BW_15002499', 'BW_2500', 'BW_UNK')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Birth Weight"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)

    theChart <- gvisPieChart(data,
                             labelvar=data[1],
                             numvar=data[2],
                             options = list(
                                 title = paste("Birth by Weight - ", input$demographicZip),
                                 height = '300'),
                             chartid='weightChart')
})

output$babyCare <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT PC_FIRST, PC_NONE, PC_SECOND, PC_THIRD, PC_UNKNOWN FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column,label FROM metadata WHERE var_column IN('PC_FIRST', 'PC_NONE', 'PC_SECOND', 'PC_THIRD', 'PC_UNKNOWN')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Prenatal Care"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    
    theChart <- gvisPieChart(data,
                             labelvar=data[1],
                             numvar=data[2],
                             options = list(
                                 title = paste("Birth by Prenatal Care - ", input$demographicZip),
                                 height = '300'),
                             chartid='babyCare')
})

output$deathChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT ALZ, CAN, CLD, DIA, HOM, HTD, HYP, INJ, LIV, OTH, PNF, STK, SUI FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column,label FROM metadata WHERE var_column IN('ALZ', 'CAN', 'CLD', 'DIA', 'HOM', 'HTD', 'HYP', 'INJ', 'LIV', 'OTH', 'PNF', 'STK', 'SUI')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Cause of Death"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    
    theChart <- gvisPieChart(data,
                             labelvar=data[1],
                             numvar=data[2],
                             options = list(
                                 title = paste("Death Breakdown - ", input$demographicZip),
                                 height = '400'),
                             chartid='deathChart')
})

### HEATH BEHAVIORS & OUTCOMES
output$healthOutcomes <- renderDataTable({
    input$getData
    data <- sqldf(paste0("SELECT Indicator, X", input$demographicZip, ", California FROM askchisne"))
    healthOutcomes <- head(data,-4)
    names(healthOutcomes)[2] <- paste0(input$demographicZip)
    print(healthOutcomes)  
} , options=list(pageLength = 5,
               paging = FALSE,
               searching = FALSE,
               ordering = TRUE,
               info = FALSE))

output$healthBehaviors <- renderDataTable({
    input$getData
    data <- sqldf(paste0("SELECT Indicator, X", input$demographicZip, ", California FROM askchisne"))
                  healthBehaviors <- data[-1:-10,]
                  names(healthBehaviors)[2] <- paste0(input$demographicZip)
                  print(healthBehaviors)  
} , options=list(pageLength = 5,
                 paging = FALSE,
                 searching = FALSE,
                 ordering = TRUE,
                 info = FALSE))