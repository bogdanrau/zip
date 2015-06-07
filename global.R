## LOAD REQUIRED PACKAGES
library(shiny)          ## REQUIRED FOR SHINY APPLICATION FUNCTIONALITY
library(shinyBS)        ## EXTENDS BOOTSTRAP FUNCTIONALITY TO SHINY APPS
library(shinydashboard) ## REQUIRED FOR SHINY DASHBOARD APPEARANCE
library(sqldf)          ## REQUIRED FOR RUNNING SQL STATEMENDS ON DATA FRAMES
library(RMySQL)         ## REQUIRED FOR CONNECTING TO MYSQL DATABASES
library(reshape2)       ## REQUIRED FOR TABLE RESHAPING
library(ggplot2)        ## REQUIRED FOR CHART GENERATION
library(googleVis)      ## REQUIRED FOR INTERACTIVE CHART GENERATION
library(dplyr)          ## REQUIRED FOR DATA MANIPULATION
library(leaflet)        ## LEAFLET FOR MAPS
library(ggmap)         ## USED TO REVERSE GEOCODE

app_version <- as.character("0.0.1")
last_modified <- as.Date(file.info("ui.R")$mtime)

## LOAD ADDITIONAL SCRIPTS
source("server/options.R", local=TRUE)
source("scripts/functions.R", local=TRUE)
load("zips.Rda")       ## LOAD ZIP CODES

## GLOBAL OPTIONS
options(sqldf.driver = 'SQLite')    # Use SQLite driver. Needed to not conflict with RMySQL

mysqlconf <- "/home/bogdan/R-Programs/my.cnf"
## FUNCTION FOR SQL DATABASE CONNECTION
## PREVENTS OVERUSING THE CONNECTION

getConnection <- function(group) {
    
    if (!exists('connection', where=.GlobalEnv)) {
        connection <<- dbConnect(MySQL(), default.file=mysqlconf, group='client', dbname='community_beat')
    } else if (class(try(dbGetQuery(connection, "SELECT 1"))) == "try-error") {
        dbDisconnect(connection)
        connection <<- dbConnect(MySQL(), default.file=mysqlconf, group='client', dbname='community_beat')
    }
    
    return(connection)
}

## INPUT OPTIONS
## Initialize selectizeInputs with placemarks
demographicsZipOptions <- list(
    placeholder = "Choose or Search for a ZIP Code",
    onInitialize = I('function() { this.setValue(""); }')
)