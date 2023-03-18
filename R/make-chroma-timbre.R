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
  geom_tile() +
  labs(x = "Chroma", y = NULL, fill = "Magnitude") +
  theme_minimal() +
  scale_fill_viridis_c() 

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
  geom_tile() +
  labs(x = "Timbre", y = NULL, fill = "Magnitude") +
  scale_fill_viridis_c() +                              
  theme_classic()

saveRDS(object = plot_at_chroma, file = "data/plot_at_chroma.RDS")
saveRDS(object = plot_at_timbre, file = "data/plot_at_timbre.RDS")
