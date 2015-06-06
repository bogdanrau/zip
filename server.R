## LOAD OUTSIDE SCRIPTS/RESOURCES
source("global.R")

shinyServer(function(input, output, session) {
    
    ## CONNECT TO SQL TABLES
    connection <- withProgress(message = 'Connecting:', detail = 'CalZIP database...', value = 0.3, {
        getConnection()
    })
    
    
    
})