library(flexdashboard)
library(readr)
library(leaflet)
library(DT)
library(tidyverse)
library(lubridate)
library(plotly)
library(spotifyr)
library(Cairo)
library(compmus)
library(grid)
library(gridExtra)

same <- data.frame(song=c("Bohemian Rhapsody - Remastered 2011", "Breaking My Own Heart", 
                          "Cajun Moon", "Call Me The Breeze", "Disco Inferno",
                          "Goodbye Yellow Brick Road", "I Knew You Were Waiting (For Me)",
                          "Stop", "Take My Breath"), 
                   artist=c("Queen", "Duffy", "J.J. Cale", "J.J. Cale", "The Trammps",
                            "Elton John", "George Michael, Aretha Franklin", "Duffy",
                            "The Weeknd"), 
                   added=c("Julia & Roos", "Julia & Roos", "Julia & Willemijn",
                            "Julia & Willemijn", "Julia & Willemijn", "Julia & Roos", 
                            "Julia & Roos", "Julia & Roos", "Julia & Roos")
                   )

cover <- data.frame(song1=c("Crazy Little Thing Called Love - Acoustic Version"),
                    artist1=c("Maroon 5"),
                    added1=c("Roos"),
                    song2=c("Crazy Little Thing Called Love - Remastered 2011"),
                    artist2=c("Queen"),
                    added2=c("Julia"))

same_plot <- ggplot(same, aes(added)) + geom_hist()

same_plot