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

tempogram1 <- get_tidy_audio_analysis('3Fcfwhm8oRrBvBZ8KGhtea') |> 
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |> 
  ggplot(aes(x = time, y = bpm, fill = power)) + 
  geom_raster() + 
  scale_fill_viridis_c(guide = 'none') +
  labs(x = 'Time (s)', y = 'Tempo (BPM)', title='Viva La Vida - Coldplay') +
  theme_classic()

saveRDS(object = tempogram1, file = "data/tempogram1.RDS")

tempogram2 <- get_tidy_audio_analysis('1n7xFAY4xoPeqRvrkzAtsw') |> 
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |> 
  ggplot(aes(x = time, y = bpm, fill = power)) + 
  geom_raster() + 
  scale_fill_viridis_c(guide = 'none') +
  labs(x = 'Time (s)', y = 'Tempo (BPM)', title='Good Old-Fashioned Lover Boy - Queen') +
  theme_classic()

saveRDS(object = tempogram2, file = "data/tempogram2.RDS")

tempogram3 <- get_tidy_audio_analysis('5IWW129DwGyMVQAbaJz3rS') |> 
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |> 
  ggplot(aes(x = time, y = bpm, fill = power)) + 
  geom_raster() + 
  scale_fill_viridis_c(guide = 'none') +
  labs(x = 'Time (s)', y = 'Tempo (BPM)', title='King of Everything - Dominic Fike') +
  theme_classic()

saveRDS(object = tempogram3, file = "data/tempogram3.RDS")

tempogram4 <- get_tidy_audio_analysis('2ygvZOXrIeVL4xZmAWJT2C') |> 
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |> 
  ggplot(aes(x = time, y = bpm, fill = power)) + 
  geom_raster() + 
  scale_fill_viridis_c(guide = 'none') +
  labs(x = 'Time (s)', y = 'Tempo (BPM)', title='my future - Billie Eilish') +
  theme_classic()

saveRDS(object = tempogram4, file = "data/tempogram4.RDS")
