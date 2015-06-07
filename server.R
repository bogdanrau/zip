## LOAD OUTSIDE SCRIPTS/RESOURCES
source("global.R")

shinyServer(function(input, output, session) {
    
    ## CONNECT TO SQL TABLES
    connection <- withProgress(message = 'Connecting:', detail = 'Community-Beat database...', value = 0.3, {
        getConnection()
    })
    
    ## INFO BOXES (4x2)
    source("server/info-box.R", local=TRUE)
    
    ## DEMOGRAPHICS
    source("server/demographics.R", local=TRUE)
    
    ## BIRTHS & DEATHS
    source("server/bd.R", local=TRUE)
    
    ## POLUTION
    source("server/polution.R", local=TRUE)
    
    ## ECONOMY
    source("server/economy.R", local=TRUE)
    
    ## MAPPER
    source("server/mapper.R", local=TRUE)
    
    
    
})