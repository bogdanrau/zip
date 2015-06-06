body <- dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href="zip.css")),
    fluidRow(
        column(3, 
               selectizeInput("demographicsZip", label = "Choose/Search for a ZIP Code:", options=demographicsZipOptions, choices=c("90001", "90002"))
               ),
        column(2,
               actionButton("getDemographicData", label = "Build Profile", icon = icon("search"), class = "ZIP-button")
               )
        ),
    conditionalPanel(condition="input.getDemographicData > 0", 
        fluidRow(
            infoBox("Total Population", "52,590", icon = icon("user"), width = 3),
            infoBox("Median Age", "31.5 years", icon = icon("clock-o"), color = "purple", width = 3),
            infoBox("Percent Unemployed", "5.6%", icon = icon("briefcase"), color = "orange", width = 3),
            infoBox("Median Household Income", "$45,313", icon = icon("usd"), color = "green", width = 3)
            ),
        fluidRow(
            valueBox("Top 5%", HTML("<span id='hbs'>Healthy Beginnings Score <i class='fa fa-question-circle'></i></span>"), icon = icon("child"), color = "yellow", width = 3),
            valueBox("LOW (3.5)", HTML("<span id='pb'>Pollution Burden <i class='fa fa-question-circle'></i></span>"), icon = icon("globe"), color = "olive", width = 3),
            valueBox("Top 35%", HTML("<span id='les'>Local Economy Score <i class='fa fa-question-circle'></i></span>"), icon = icon("line-chart"), color = "teal", width = 3),
            valueBox("GOOD (2.2)", HTML("<span id='hmh'>Market Health Index <i class='fa fa-question-circle'></i></span>"), icon = icon("home"), color = "maroon", width = 3)
            ),
        fluidRow(
            box(title = "Demographics",
                status = "primary",
                solidHeader = TRUE,
                width = 12,
                collapsible = TRUE,
                    tabsetPanel(
                        tabPanel("Age & Gender"),
                        tabPanel("Race & Ethnicity"),
                        tabPanel("Education"),
                        tabPanel("Income & Poverty"),
                        tabPanel("Citizenship"),
                        tabPanel("Employment Status"),
                        tabPanel("Foot Stamps")
                    )
                )
            ),
        fluidRow(
            box(title = "Birth & Death",
                status = "success",
                solidHeader = TRUE,
                width = 12,
                collapsible = TRUE,
                    tabsetPanel(
                        tabPanel("Birth Facts"),
                        tabPanel("Low Birth Weight"),
                        tabPanel("Prenatal Care"),
                        tabPanel("Deaths")
                    )
                )
            ),
        fluidRow(
            box(title = "Environmental Health",
                status = "warning",
                solidHeader = TRUE,
                width = 12,
                collapsible = TRUE,
                    tabsetPanel(
                        tabPanel("Pollution Burden"),
                        tabPanel("Air"),
                        tabPanel("Water"),
                        tabPanel("Ground")
                    )
            )
        ),
        fluidRow(
            box(title = "Local Economy",
                status = "danger",
                solidHeader = TRUE,
                width = 12,
                collapsible = TRUE,
                    tabsetPanel(
                        tabPanel("Businesses"),
                        tabPanel("Taxes"),
                        tabPanel("Housing"),
                        tabPanel("Income Inequality")
                    )
            )
        )
    )
)