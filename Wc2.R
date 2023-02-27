library(flexdashboard)
library(Cairo)

chroma <-
  get_tidy_audio_analysis("5aYJ6gZyTFxZPAyTRRWKxP") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

chroma2 <-
  get_tidy_audio_analysis("6xdLJrVj4vIXwhuG8TMopk") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

compmus_long_distance(
  chroma |> mutate(pitches = map(pitches, compmus_normalise, "chebyshev")),
  chroma2 |> mutate(pitches = map(pitches, compmus_normalise, "chebyshev")),
  feature = pitches,
  method = "euclidean"
) |>
  ggplot(
    aes(
      x = xstart + xduration / 2,
      width = xduration,
      y = ystart + yduration / 2,
      height = yduration,
      fill = d
    )
  ) +
  geom_tile() +
  coord_equal() +
  labs(x = "Maroon 5", y = "Queen") +
  theme_minimal() +
  scale_fill_viridis_c(guide = NULL)