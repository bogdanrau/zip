body <- dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href="zip.css")),
    tags$head(includeScript("www/googleAnalytics.js")),
    fluidRow(
        column(3, 
               selectizeInput("demographicZip", label = "Choose/Search for a ZIP Code:", options=demographicsZipOptions, choices=demographicZips)
               ),
        column(2,
               actionButton("getData", label = "Build Profile", icon = icon("search"), class = "ZIP-button")
               )
        ),
    conditionalPanel(condition="input.getData > 0", 
        fluidRow(
            infoBox("Total Population", textOutput("total_population"), icon = icon("user"), width = 3),
            infoBox("Median Age", textOutput("median_age"), icon = icon("clock-o"), color = "purple", width = 3),
            infoBox("Percent Unemployed", textOutput("percent_unemployed"), icon = icon("briefcase"), color = "orange", width = 3),
            infoBox("Median Household Income", textOutput("median_income"), icon = icon("usd"), color = "green", width = 3)
            ),
        fluidRow(
            valueBox(textOutput("healthy_beginnings"), HTML("<span>Healthy Beginnings Ranking <i class='fa fa-question-circle' id='hbs'></i></span>"), icon = icon("child"), color = "yellow", width = 3),
            bsTooltip("hbs", "The Healthy Beginnings Ranking takes into account birth weight and the inception of prenatal care.", "top"),
            valueBox(textOutput("polutant_burden"), HTML("<span id='pb'>Pollution Burden <i class='fa fa-question-circle'></i></span>"), icon = icon("globe"), color = "olive", width = 3),
            bsTooltip("pb", "CalEnviroScreen (CES) 2.0 is a summary measure that can be used to help identify California communities that are disproportionately burdened by multiple sources of pollution", "top"),
            valueBox(textOutput("localEconomyIndex"), HTML("<span id='les'>Local Economy Ranking <i class='fa fa-question-circle'></i></span>"), icon = icon("line-chart"), color = "teal", width = 3),
            bsTooltip("les", "The Local Economy Ranking uses multiple economic factors, such as employment, income, payroll and more to provide a summary (at-a-glance) measure.", "top"),
            valueBox(textOutput("marketHealthIndex"), HTML("<span id='hmh'>Housing Health Index <i class='fa fa-question-circle'></i></span>"), icon = icon("home"), color = "maroon", width = 3),
            bsTooltip("hmh", "Housing Market Health Index provided by Zillow averaged over 12 months for 2012.", "top")
            ),
        fluidRow(
            box(title = "Demographics",
                status = "primary",
                solidHeader = TRUE,
                width = 12,
                collapsible = TRUE,
                    tabsetPanel(
                        tabPanel("Age & Gender",
                                 fluidRow(column(6,
                                 dataTableOutput("age_breakdown"),
                                 br(),
                                 dataTableOutput("gender_breakdown")),
                                 column(6,
                                        htmlOutput("ageChart")))),
                        tabPanel("Race & Ethnicity",
                                 fluidRow(column(6,
                                                 dataTableOutput("ethnicity_breakdown"),
                                                 br(),
                                                 dataTableOutput("race_breakdown")),
                                          column(6,
                                                 htmlOutput("raceChart")))),
                        tabPanel("Education",
                                 fluidRow(column(6,
                                                 dataTableOutput("education_breakdown2"),
                                                 br(),
                                                 dataTableOutput("education_breakdown")
                                                 ),
                                          column(6,
                                                 htmlOutput("educationChart"),
                                                 br(),
                                                 htmlOutput("educationChart2")))),
                        tabPanel("Income & Poverty",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("poverty"),
                                            br()),
                                     column(6))),
                        tabPanel("Citizenship",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("nativity"),
                                            br()),
                                     column(6,
                                            htmlOutput("citizenshipChart")))),
                        tabPanel("Employment Status",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("employment_status"),
                                            br()),
                                     column(6))),
                        tabPanel("Food Stamps",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("food_stamps"),
                                            br()),
                                     column(6)))
                    )
                )
            ),
        fluidRow(
            box(title = "Birth, Death & Health",
                status = "success",
                solidHeader = TRUE,
                width = 12,
                collapsible = TRUE,
                    tabsetPanel(
                        tabPanel("Birth Facts",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("birth_age"),
                                            br(),
                                            dataTableOutput("birth_race")),
                                     column(6,
                                            htmlOutput("babyAgeChart"),
                                            htmlOutput("babyRaceChart")))),
                        tabPanel("Low Birth Weight",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("birth_weight"),
                                            br()),
                                     column(6, htmlOutput("weightChart")))),
                        tabPanel("Prenatal Care",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("prenatal_care"),
                                            br()),
                                     column(6,
                                            htmlOutput("babyCare")))),
                        tabPanel("Deaths",
                                 fluidRow(
                                     column(6, 
                                            dataTableOutput("deaths"),
                                            br()),
                                     column(6,
                                            htmlOutput("deathChart"))))
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
                        tabPanel("Pollution Burden",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("CES"),
                                            br()),
                                     column(1),
                                     column(5,
                                            htmlOutput("polutionGauge")))),
                        tabPanel("Air",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("air"),
                                            br()),
                                     column(6))),
                        tabPanel("Water",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("water"),
                                            br()),
                                     column(6))),
                        tabPanel("Ground",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("ground"),
                                            br()),
                                     column(6)))
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
                        tabPanel("Businesses",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("business"),
                                            br()),
                                     column(6))),
                        tabPanel("Taxes",
                                 fluidRow(
                                     column(6, 
                                            dataTableOutput("taxes"),
                                            br()),
                                     column(6))),
                        tabPanel("Housing",
                                 fluidRow(
                                     column(6, 
                                            dataTableOutput("zillow"),
                                            br()),
                                     column(6,
                                            dataTableOutput("medianRent"),
                                            dataTableOutput("rentown")))),
                        tabPanel("Income Inequality",
                                 fluidRow(
                                     column(6,
                                            dataTableOutput("income_inequality"),
                                            br()),
                                     column(6)))
                    )
            )
        ),
        fluidRow(
            box(title = "MAPPER (Coming soon)",
                status = "success",
                solidHeader = TRUE,
                width = 12,
                collapsible = TRUE,
                leafletOutput("myMap")
        )),
        fluidRow(
            column(12,
                   HTML("<div class='footer-center'><a href='https://github.com/bogdanrau/zip'>Fork us on <i class='fa fa-github'></i> Github!</a></div>")
                )
            )
    )
)