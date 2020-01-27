
library(shiny)
library(shinydashboard)
library(googleVis)
library(DT)
library(rsconnect) 
library(ggplot2)
library(dplyr)

## code to load data

load('input2/accidents_all.Rdata')
load('input2/severity.Rdata')
load('input2/data_sample.Rdata')
severity$Year = factor(severity$Year)
severity$Severity = factor(severity$Severity)
#load('input/data.Rdata')
#note to anyone who wants to use my code: comment out 'load' lines when need to run the app often to save time

options(scipen = 999) # this is to remove the scientific notation in the graph outputs
