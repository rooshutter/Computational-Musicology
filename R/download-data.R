library(spotifyr)
library(flexdashboard)
library(readr)
library(leaflet)
library(DT)
library(tidyverse)
library(lubridate)
library(plotly)

Sys.setenv(SPOTIFY_CLIENT_ID = 'c6d2017616c34106a1b1c8407f7fbc6e')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '1bee2b2375da4f9a9332a114d31d0da7')
access_token <- get_spotify_access_token()

otra <- get_playlist_audio_features("", "6cZQQaJ0MsSHyUfGyuLgGK")

#otra_j <- otra1 %>%
  #filter(added_by.id == '1153531084') %>%
 # mutate(added_by.id = "Julia")

#otra_w <- otra1 %>%
 # filter(added_by.id == '1168120441') %>%
#  mutate(added_by.id = "Willemijn")

#otra_r <- otra1 %>%
 # filter(added_by.id == 'roos.hutter') %>%
 # mutate(added_by.id = "Roos")

#otra <- rbind(head(otra_r, 52), otra_w, head(otra_j, 52))

saveRDS(object = otra,file = "data/otra-data.RDS")

