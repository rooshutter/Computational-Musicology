library(tidyverse)
library(spotifyr)
library(compmus)
library(plotly)

at_chroma <-
  get_tidy_audio_analysis("5YCXiEpUqblYW5x9vWx8Qd") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches) |>
  mutate(pitches = map(pitches, compmus_normalise, "euclidean")) |>
  compmus_gather_chroma() 

at_timbre <-
  get_tidy_audio_analysis("5YCXiEpUqblYW5x9vWx8Qd") |> 
  compmus_align(bars, segments) |>                     `
  select(bars) |>                                      
  unnest(bars) |>                                      
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "rms", norm = "euclidean"              
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = "rms", norm = "euclidean"              
      )
  ) %>% compmus_gather_timbre()

plot_at_chroma <-
  ggplot(at_chroma,
         aes(
           x = start + duration / 2,
           width = duration,
           y = pitch_class,
           fill = value
         )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal() +
  scale_fill_viridis_c()

plot_at_timbre <-
  ggplot(at_timbre,
    aes(
      x = start + duration / 2,
      width = duration,
      y = basis,
      fill = value
    )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  scale_fill_viridis_c() +                              
  theme_classic()

chroma <-
  get_tidy_audio_analysis("5YCXiEpUqblYW5x9vWx8Qd") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

chroma <- chroma %>%
  mutate(pitches = map(pitches, compmus_normalise, "euclidean")) %>%
  compmus_gather_chroma() 

plot_chroma <-
  ggplot(chroma,
         aes(
           x = start + duration / 2,
           width = duration,
           y = pitch_class,
           fill = value
         )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal() +
  scale_fill_viridis_c()

