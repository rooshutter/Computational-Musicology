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

color_scale <- scale_color_gradient(low = "#c1c8d7", high = "#1e2d4b", guide = guide_colorbar(title = "Magnitude"))

at_chroma <-
  get_tidy_audio_analysis("5YCXiEpUqblYW5x9vWx8Qd") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches) %>%
  mutate(pitches = map(pitches, compmus_normalise, "euclidean")) %>%
  compmus_gather_chroma() 

plot_at_chroma <-
  ggplot(at_chroma,
         aes(
           x = start + duration / 2,
           width = duration,
           y = pitch_class,
           fill = value
         )
  ) +
  color_scale +
  geom_tile() +
  labs(x = "Chroma", y = NULL, fill = "Magnitude") +
  theme_minimal()

at_timbre <-
  get_tidy_audio_analysis("5YCXiEpUqblYW5x9vWx8Qd") |> # Change URI.
  compmus_align(bars, segments) |>                     # Change `bars`
  select(bars) |>                                      #   in all three
  unnest(bars) |>                                      #   of these lines.
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "rms", norm = "euclidean"              # Change summary & norm.
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = "rms", norm = "euclidean"              # Change summary & norm.
      )
  ) |> compmus_gather_timbre()

plot_at_timbre <-
  ggplot(at_timbre,
         aes(
           x = start + duration / 2,
           width = duration,
           y = basis,
           fill = value
         )
  ) +
  color_scale +
  geom_tile() +
  labs(x = "Timbre", y = NULL, fill = "Magnitude") +
  theme_classic()

subplot(plot_at_chroma, plot_at_timbre) 

saveRDS(object = plot_at_chroma, file = "data/plot_at_chroma.RDS")
saveRDS(object = plot_at_timbre, file = "data/plot_at_timbre.RDS")
