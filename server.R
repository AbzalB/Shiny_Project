shinyServer(function(input,output, session){
  

  output$link <- renderUI({
    tags$a(
      href="https://www.linkedin.com/in/abzal-bacchus-a1b2z3/", # my linkedin, feel free to connect with me :) 
      tags$img(src="ld.png", 
               title="", 
               width="45",
               height="49")
    )
    
    #tagList("URL link:", url)
  })
  
  output$total = renderInfoBox({
    infoBox(
      'Total Accidents',
    value = sum(accidents_all$`Number of Accidents`) %>% 
      format(.,big.mark=",",scientific=FALSE),
    subtitle = 'All 49 states.'
    )
  })
  
  output$total2 = renderInfoBox({
    infoBox(
      'Highest Recorded Accident', # 'Maximum number of accident out of all the years in the dataset'
      value = max(accidents_all$`Number of Accidents`)%>% 
        format(.,big.mark=",",scientific=FALSE),
      subtitle = ''
    )
  })
  
  output$gvis = renderGvis({
    
    if(input$year == 'All'){
      plotdata = accidents_all
    }else{
      plotdata = accidents_all %>% 
        filter(Year == as.numeric(input$year))
    }
    
    GeoStates <- gvisGeoChart(plotdata, "State", "Number of Accidents",
                              options=list(region="US", 
                                           displayMode="regions", 
                                           resolution="provinces",
                                           width=600, height=400))
    
  })
  
  output$top5 = renderDataTable({
    
    if(input$year == 'All'){
      tabledata = accidents_all
    }else{
      tabledata = accidents_all %>% 
        filter(Year == as.numeric(input$year)) %>% 
        select(-Year)
    }
    
    tabledata = tabledata %>% 
      arrange(desc(`Number of Accidents`)) %>% 
      .[1:5,]
    
    datatable(tabledata, options = list(searching = F, lengthChange = F, dom ='ft'), rownames = F)
  })
  
  output$bottom5 = renderDataTable({

    if(input$year == 'All'){
      tabledata = accidents_all
    }else{
      tabledata = accidents_all %>%
        filter(Year == as.numeric(input$year)) %>%
        select(-Year)
    }

    tabledata = tabledata %>%
      arrange(`Number of Accidents`) %>%
      .[1:5,]

    datatable(tabledata, options = list(searching = F, lengthChange = F, dom ='ft'), rownames = F)
  })
  
  
  output$plot1 = renderPlot({
    if(input$sev=='All'){
    ggplot(data=severity, aes(x=Year, y=Accidents, fill=Severity)) +
      geom_bar(stat='identity', position=position_dodge()) 
      }else{
        data = severity %>% 
          filter(Severity == as.numeric(input$sev))
        ggplot(data=data, aes(x=Year, y=Accidents, fill = Year)) +
          geom_bar(stat='identity', position=position_dodge()) +
          scale_colour_brewer(palette = "Set1") 
         #scale_fill_manual(values = c("grey","red","blue","orange"))
        
      }
  })
  
  output$data = renderDataTable({
    datatable(data_sample)
  })
  
})