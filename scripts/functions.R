## FUNCTION FOR INFO-BOX
# cbInfoBox <- function(what, where, condition) {
#    renderText({
#        data <- dbGetQuery(connection, paste0("SELECT ", what, " FROM", where, " WHERE zip = '", condition, "'"))
#        data <- data[1,1]
#        data <- format(data, big.mark=",")
#        print(data)
#        })
#}