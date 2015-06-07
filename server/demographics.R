## AGE & GENDER
output$age_breakdown <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT HC01_EST_VC03, 
                                                          HC01_EST_VC04,
                                                          HC01_EST_VC05, 
                                                          HC01_EST_VC06, 
                                                          HC01_EST_VC07, 
                                                          HC01_EST_VC08, 
                                                          HC01_EST_VC09, 
                                                          HC01_EST_VC10, 
                                                          HC01_EST_VC11, 
                                                          HC01_EST_VC12, 
                                                          HC01_EST_VC13, 
                                                          HC01_EST_VC14, 
                                                          HC01_EST_VC15, 
                                                          HC01_EST_VC16, 
                                                          HC01_EST_VC17, 
                                                          HC01_EST_VC18, 
                                                          HC01_EST_VC19, 
                                                          HC01_EST_VC20 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('HC01_EST_VC03', 
                                                          'HC01_EST_VC04',
                                                          'HC01_EST_VC05', 
                                                          'HC01_EST_VC06', 
                                                          'HC01_EST_VC07', 
                                                          'HC01_EST_VC08', 
                                                          'HC01_EST_VC09', 
                                                          'HC01_EST_VC10', 
                                                          'HC01_EST_VC11', 
                                                          'HC01_EST_VC12', 
                                                          'HC01_EST_VC13', 
                                                          'HC01_EST_VC14', 
                                                          'HC01_EST_VC15', 
                                                          'HC01_EST_VC16', 
                                                          'HC01_EST_VC17', 
                                                          'HC01_EST_VC18', 
                                                          'HC01_EST_VC19', 
                                                          'HC01_EST_VC20')")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Age Category"
    names(data)[2]<-"Estimate"
    
    print(data)
    }, options=list(pageLength = 5,
                         paging = TRUE,
                         searching = FALSE,
                         ordering = TRUE,
                         info = FALSE)
)

output$gender_breakdown <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT Males, Females FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('Males', 
                                                      'Females')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Gender"
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

## RACE & ETHNICITY
output$ethnicity_breakdown <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT HD01_VD03, NHL FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('HD01_VD03', 
                                                      'NHL')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Ethnicity"
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

output$race_breakdown <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT AI, Asian, Black, NH, White, Other, Two FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('AI', 
                                                      'Asian',
                                                        'Black',
                                                        'NH',
                                                        'White',
                                                        'Other',
                                                        'Two')
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

## EDUCATION
output$education_breakdown <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT LT9G, ND912, HSG, SCND, AD, BD, GPD FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('LT9G', 
                                                      'ND912',
                                                      'HSG',
                                                      'SCND',
                                                        'AD',
                                                        'BD',
                                                        'GPD')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Education Status (25+)"
    names(data)[2]<-"Estimate (%)"
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
    )

output$education_breakdown2 <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT LH1824, HS1824, SCAD1824, BDH1824 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('LH1824',
                                                      'HS1824',
                                                      'SCAD1824',
                                                        'BDH1824')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Education Status (18-24)"
    names(data)[2]<-"Estimate (%)"
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
    )

## INCOME & POVERTY
output$poverty <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT Poverty FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('Poverty')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Poverty Status"
    names(data)[2]<-"Estimate (%)"
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
    )

## CITIZENSHIP
output$nativity <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT CBUS, CBPR, HD01_VD04, HD01_VD05, HD01_VD06 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('CBUS', 'CBPR', 'HD01_VD04', 'HD01_VD05', 'HD01_VD06')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Nativity Status"
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

## EMPLOYMENT STATUS
output$employment_status <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT Employed, HC04_EST_VC01 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('Employed', 'HC04_EST_VC01')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Employment Status"
    names(data)[2]<-"Estimate (%)"
    
    print(data)
}, options=list(pageLength = 5,
                paging = FALSE,
                searching = FALSE,
                ordering = TRUE,
                info = FALSE)
)

## FOOD STAMPS
output$food_stamps <- renderDataTable ({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT HC02_EST_VC01, HC03_EST_VC01 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('HC02_EST_VC01', 'HC03_EST_VC01')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Food Stamp Status"
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
output$ageChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT HC01_EST_VC03, 
                                                          HC01_EST_VC04,
                                                  HC01_EST_VC05, 
                                                  HC01_EST_VC06, 
                                                  HC01_EST_VC07, 
                                                  HC01_EST_VC08, 
                                                  HC01_EST_VC09, 
                                                  HC01_EST_VC10, 
                                                  HC01_EST_VC11, 
                                                  HC01_EST_VC12, 
                                                  HC01_EST_VC13, 
                                                  HC01_EST_VC14, 
                                                  HC01_EST_VC15, 
                                                  HC01_EST_VC16, 
                                                  HC01_EST_VC17, 
                                                  HC01_EST_VC18, 
                                                  HC01_EST_VC19, 
                                                  HC01_EST_VC20 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('HC01_EST_VC03', 
                                                      'HC01_EST_VC04',
                                                      'HC01_EST_VC05', 
                                                      'HC01_EST_VC06', 
                                                      'HC01_EST_VC07', 
                                                      'HC01_EST_VC08', 
                                                      'HC01_EST_VC09', 
                                                      'HC01_EST_VC10', 
                                                      'HC01_EST_VC11', 
                                                      'HC01_EST_VC12', 
                                                      'HC01_EST_VC13', 
                                                      'HC01_EST_VC14', 
                                                      'HC01_EST_VC15', 
                                                      'HC01_EST_VC16', 
                                                      'HC01_EST_VC17', 
                                                      'HC01_EST_VC18', 
                                                      'HC01_EST_VC19', 
                                                      'HC01_EST_VC20')")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Age Category"
    names(data)[2]<-"Estimate"
    
    theChart <- gvisPieChart(data,
                              labelvar=data[1],
                              numvar=data[2],
                              options = list(
                                  title = paste("Age breakdown - ", input$demographicZip),
                                  height = '400'),
                              chartid='ageChart')
})

output$raceChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT AI, Asian, Black, NH, White, Other, Two FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('AI', 
                                                      'Asian',
                                                      'Black',
                                                      'NH',
                                                      'White',
                                                      'Other',
                                                      'Two')
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
                              numvar=data[2],
                              options = list(
                                  title = paste("Race breakdown - ", input$demographicZip),
                                  height = '400'),
                              chartid='raceChart')
})

output$educationChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT LT9G, ND912, HSG, SCND, AD, BD, GPD FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('LT9G', 
                                                      'ND912',
                                                      'HSG',
                                                      'SCND',
                                                        'AD',
                                                        'BD',
                                                        'GPD')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Education Status (25+)"
    names(data)[2]<-"Estimate (%)"
    
    theChart <- gvisColumnChart(data,
#                               xvar=data[1],
#                               yvar=data[2],
                              options = list(
                                  title = paste("Education (18-24) - ", input$demographicZip),
                                  height = '200',
                                  hAxis = "{title: 'Education'}",
                                  vAxis = "{title: 'Estimate'}"),
                              chartid='educationChart')
})

output$educationChart2 <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT LT9G, ND912, HSG, SCND, AD, BD, GPD FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN ('LT9G', 
                                                      'ND912',
                                                      'HSG',
                                                      'SCND',
                                                      'AD',
                                                      'BD',
                                                      'GPD')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Education Status (25+)"
    names(data)[2]<-"Estimate (%)"
    
    theChart <- gvisColumnChart(data,
                                #                               xvar=data[1],
                                #                               yvar=data[2],
                                options = list(
                                    title = paste("Education (25+) - ", input$demographicZip),
                                    height = '300',
                                    hAxis = "{title: 'Education'}",
                                    vAxis = "{title: 'Estimate'}"),
                                chartid='educationChart2')
})

output$citizenshipChart <- renderGvis({
    input$getData
    data <- isolate(dbGetQuery(connection, paste0("SELECT CBUS, CBPR, HD01_VD04, HD01_VD05, HD01_VD06 FROM data WHERE zip = '", input$demographicZip, "'")))
    data <- melt(data)
    metadata <- isolate(dbGetQuery(connection, paste0("SELECT var_column, label FROM metadata WHERE var_column IN('CBUS', 'CBPR', 'HD01_VD04', 'HD01_VD05', 'HD01_VD06')
                                                      ")))
    
    data <- sqldf("SELECT t1.label, t2.value FROM metadata AS t1
                  LEFT JOIN data AS t2 ON t1.var_column=t2.variable")
    names(data)[1]<-"Nativity Status"
    names(data)[2]<-"Estimate"
    total <- sum(data$Estimate)
    data$Percent <- (data$Estimate/total)
    data$Percent <- data$Percent*100
    data$Percent <- round(data$Percent, digits=2)
    
    theChart <- gvisPieChart(data,
                             labelvar=data[1],
                             numvar=data[2],
                             options = list(
                                 title = paste("Citizenship Breakdown - ", input$demographicZip),
                                 height = '300'),
                             chartid='citizenshipChart')
})
