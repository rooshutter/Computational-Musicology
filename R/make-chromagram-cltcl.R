chroma <-
  get_tidy_audio_analysis("5aYJ6gZyTFxZPAyTRRWKxP") |>
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

chroma2 <-
  get_tidy_audio_analysis("6xdLJrVj4vIXwhuG8TMopk") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

chroma2 <- chroma2 %>%
  mutate(pitches = map(pitches, compmus_normalise, "euclidean")) %>%
  compmus_gather_chroma() 

plot_chroma2 <-
  ggplot(chroma2,
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
  scale_fill_viridis_c() + 
  theme(legend.position = "none") 

saveRDS(object = plot_chroma, file = "data/plot_chroma.RDS")
saveRDS(object = plot_chroma2, file = "data/plot_chroma2.RDS")
