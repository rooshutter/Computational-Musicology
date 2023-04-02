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


tempogram1 <- get_tidy_audio_analysis('4cluDES4hQEUhmXj6TXkSo') |> 
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |> 
  ggplot(aes(x = time, y = bpm, fill = power)) + 
  geom_raster() + 
  labs(x = 'Time (s)', y = 'Tempo (BPM)', title='What Makes You Beautiful - One Direction') +
  theme_classic()+ 
  theme(legend.position = "none") 

saveRDS(object = tempogram1, file = "data/tempogram1.RDS")

tempogram2 <- get_tidy_audio_analysis('2Dpe2dH0Dvj2iVnDQvMv1E') |> 
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |> 
  ggplot(aes(x = time, y = bpm, fill = power)) + 
  geom_raster() + 
  labs(x = 'Time (s)', y = 'Tempo (BPM)', title='Stutter - Maroon 5') +
  theme_classic()+ 
  theme(legend.position = "none") 

saveRDS(object = tempogram2, file = "data/tempogram2.RDS")

tempogram3 <- get_tidy_audio_analysis('1znGxpojJSjxZZEWA5zWva') |> 
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |> 
  ggplot(aes(x = time, y = bpm, fill = power)) + 
  geom_raster() + 
  labs(x = 'Time (s)', y = 'Tempo (BPM)', title='Still Counting - Volbeat') +
  theme_classic()+ 
  theme(legend.position = "none") 

saveRDS(object = tempogram3, file = "data/tempogram3.RDS")


