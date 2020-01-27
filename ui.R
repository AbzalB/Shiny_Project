library(shiny)

header <- dashboardHeader(
  disable  = F, title = 'U.S Accidents',
  uiOutput('link')
# tags$li(class = 'dropdown',img(src = 'img.png', height = '60px', width = '120px'),
#         href="https://www.google.com")
)

sidebar <- dashboardSidebar(collapsed = F, 
                            
                            img(src = 'img.png', height = '60px', width = '120px'),
                            sidebarMenu
                            (
                              menuItem("Accident Statistics", tabName = "tab1", icon = icon("chart-line" ))
                            ),
                            sidebarMenu
                            (
                              menuItem("Accident Severity", tabName = "tab1_2", icon = icon("chart-bar" ))
                            ),
                            sidebarMenu(
                              menuItem("Data", tabName = "tab2")
                            ),
                            sidebarMenu(
                              menuItem("About", tabName = "about")
                            )
                            )

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = 'tab1',
      fluidPage(
        infoBoxOutput('total'),
        infoBoxOutput('total2'),
 
        column(width = 9,
        box( solidHeader = T, status = "primary",   width = 12, title = "Data",
             htmlOutput('gvis')
          )),
          column(width = 3,
                 selectInput('year','Select Year',choices = c('All',2016,2017,2018,2019)),
          h5('States with most accidents'),
          dataTableOutput('top5'),
          h5('States with least accidents'),
          dataTableOutput('bottom5')
          
          )

      )
   
      
    ),
    # tab with bar chart
    tabItem(
      tabName = 'tab1_2',
      fluidPage(
        column(9,
               box( solidHeader = T, status = "primary",   width = 12, title = "Accident Severity Chart",
                    plotOutput('plot1')
                    ),
             
               ),
        column(3,
               selectInput('sev','Select the severity', choices = c('All',1,2,3,4))
               )
      )
    ),
    # tab with data
    tabItem(
      tabName = 'tab2',
      dataTableOutput('data')
    ),
    tabItem(
      tabName = 'about',
      " - this is a countrywide traffic accident dataset, which covers 49 states of the United States",
      br(),
      " - the data is collected from February 2016 to December 2019 (ongoing), using several data providers, two APIs which provide streaming traffic event data",
      br(),
      " - these APIs broadcast traffic events captured by a variety of entities, such as the US and state departments of transportation, law enforcement agencies, traffic cameras, and traffic sensors within the road-networks.",
      br(),
      " - about 3.0 million accident records in this dataset",
      br()
      #HTML(paste0("<b>", "<span style=\"color:black\">Thank you</span>","</b>" ))
      

    )
  )
  
 
)


ui <- dashboardPage(
  title = 'My Project', skin = "blue" ,
  header,sidebar,body)
