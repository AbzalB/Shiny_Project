# img source for line 11: https://www.1800leefree.com/blog/clinton-county-fatal-car-accident/ 
# this is final version 
library(DT)
library(shiny)
library(shinydashboard)
library(rsconnect)

shinyUI(dashboardPage(
    dashboardHeader(
        title = "My Dashboard"), 
    dashboardSidebar(
        
        sidebarUserPanel("US Accidents",
                         image = "https://1800leefree-gbycpnmffy9.netdna-ssl.com/wp-content/uploads/2018/04/Steinberg-broadside-crash-300x300.jpg"),
        sidebarMenu(
            menuItem("Map", tabName = "map", icon = icon("map")),
            menuItem("Graph", tabName = "graph", icon = icon("map")),
            menuItem("Data", tabName = "data", icon = icon("database"))
        ),
        selectizeInput("selected",
                       "Select Item to Display",
                       choice)
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = "map",
                    fluidRow(infoBoxOutput("maxBox"),
                             infoBoxOutput("minBox"),
                             infoBoxOutput("avgBox")),
                    fluidRow(box(htmlOutput("map"), height = 300),
                             box(htmlOutput("hist"), height = 300))),
            tabItem(tabName = "data",
                    fluidRow(box(DT::dataTableOutput("table"), width = 12)))
        )
    )
))