## LOAD OUTSIDE SCRIPTS & RESOURCES
source("global.R")
source("ui/header.R", local=TRUE)
source("ui/sidebar.R", local=TRUE)
source("ui/body.R", local=TRUE)

dashboardPage(
    header,
    sidebar,
    body
    )