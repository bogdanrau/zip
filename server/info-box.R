## TOP ROW
##########
## TOTAL POPULATION
output$total_population <- renderText({
    input$getData
    total_population <- isolate(dbGetQuery(connection, paste0("SELECT SATotalPopulation FROM data WHERE zip = '", input$demographicZip, "'")))
    total_population <- total_population[1,1]
    total_population <- format(total_population, big.mark=",")
    print(total_population)
})

## MEDIAN AGE
output$median_age <- renderText({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT HD01_VD02 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- data[1,1]
    data <- round(data, digits = 1)
    data <- paste0(data, " years")
    print(data)
})

## PERCENT UNEMPLOYED
output$percent_unemployed <- renderText({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT HC04_EST_VC01 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- data[1,1]
    data <- round(data, digits = 1)
    data <- paste0(data, "%")
    print(data)
})

## MEDIAN HOUSEHOLD INCOME
output$median_income <- renderText({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT HC02_EST_VC02 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- data[1,1]
    data <- format(data, big.mark=",")
    data <- paste0("$", data)
    print(data)
})
# ##########
# 
# ## BOTTOM ROW
# #############

## HEALTHY BEGINNINGS INDEX
output$healthy_beginnings <- renderText({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT babyindexpct FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- data[1,1]*100
    
    if (data >= 99) {
        qualifier <- as.character("Top 1%")
    } else if (data >= 95 & data < 99) {
        qualifier <- as.character("TOP 5%")
    } else if (data >= 90 & data < 95) {
        qualifier <- as.character("TOP 10%")
    } else if (data >= 80 & data < 90) {
        qualifier <- as.character("TOP 20%")
    } else if (data >= 70 & data < 80) {
        qualifier <- as.character("TOP 70%")
    } else if (data >= 60 & data < 70) {
        qualifier <- as.character("TOP 60%")
    } else if (data >= 50 & data < 60) {
        qualifier <- as.character("TOP 50%")
    } else if (data >= 40 & data < 50) {
        qualifier <- as.character("BOTTOM 40%")
    } else if (data >= 30 & data < 40) {
        qualifier <- as.character("BOTTOM 30%")
    } else if (data >= 20 & data < 30) {
        qualifier <- as.character("BOTTOM 20%")
    } else if (data >= 10 & data < 20) {
        qualifier <- as.character("BOTTOM 10%")
    } else if (data >= 5 & data < 10) {
        qualifier <- as.character("BOTTOM 5%")
    } else if (data >= 1 & data < 5) {
        qualifier <- as.character("BOTTOM 1%")
    } 
    
    print(qualifier)
})

## LOCAL ECONOMY INDEX
output$localEconomyIndex <- renderText({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT LocalEconomyPct FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- data[1,1]*100
    
    if (data >= 99) {
        qualifier <- as.character("Top 1%")
    } else if (data >= 95 & data < 99) {
        qualifier <- as.character("TOP 5%")
    } else if (data >= 90 & data < 95) {
        qualifier <- as.character("TOP 10%")
    } else if (data >= 80 & data < 90) {
        qualifier <- as.character("TOP 20%")
    } else if (data >= 70 & data < 80) {
        qualifier <- as.character("TOP 70%")
    } else if (data >= 60 & data < 70) {
        qualifier <- as.character("TOP 60%")
    } else if (data >= 50 & data < 60) {
        qualifier <- as.character("TOP 50%")
    } else if (data >= 40 & data < 50) {
        qualifier <- as.character("BOTTOM 40%")
    } else if (data >= 30 & data < 40) {
        qualifier <- as.character("BOTTOM 30%")
    } else if (data >= 20 & data < 30) {
        qualifier <- as.character("BOTTOM 20%")
    } else if (data >= 10 & data < 20) {
        qualifier <- as.character("BOTTOM 10%")
    } else if (data >= 5 & data < 10) {
        qualifier <- as.character("BOTTOM 5%")
    } else if (data >= 1 & data < 5) {
        qualifier <- as.character("BOTTOM 1%")
    } 
    
    print(qualifier)
})

## POLUTANT BURDEN
output$polutant_burden <- renderText({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT aveCESscore FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- data[1,1]
    
    if (data >= 0 & data <18.75) {
        qualifier <- as.character("Great")
    } else if (data >= 18.75 & data < 41.33) {
        qualifier <- as.character("Good")
    } else if (data >= 41.33 & data < 60.08) {
        qualifier <- as.character("Bad")
    } else if (data >= 60.08) {
        qualifier <- as.character("Worse")
    }
    
    data <- paste0(qualifier, " (", data, ")")
    print(data)
})

## MARKET HEALTH INDEX
output$marketHealthIndex <- renderText({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT MarketHealthIndex FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- data[1,1]
    
    if (data >= 0 & data < 2.77) {
        qualifier <- as.character("Worse")
    } else if (data >= 2.77 & data < 5.17) {
        qualifier <- as.character("Bad")
    } else if (data >= 5.17 & data < 7.57) {
        qualifier <- as.character("Good")
    } else if (data >= 7.57) {
        qualifier <- as.character("Great")
    }

    data <- paste0(qualifier, " (", data, ")")
    print(data)
})
# #############