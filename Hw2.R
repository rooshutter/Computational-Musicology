library(tidyverse)
library(spotifyr)
library(flexdashboard)
library(Cairo)
library(compmus)

Sys.setenv(SPOTIFY_CLIENT_ID = 'c6d2017616c34106a1b1c8407f7fbc6e')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '1bee2b2375da4f9a9332a114d31d0da7')
access_token <- get_spotify_access_token()

otra1 <- get_playlist_audio_features("", "6cZQQaJ0MsSHyUfGyuLgGK")

otra_j <- otra1 %>%
  filter(added_by.id == '1153531084') %>%
  mutate(added_by.id = "Julia")

otra_w <- otra1 %>%
  filter(added_by.id == '1168120441') %>%
  mutate(added_by.id = "Willemijn")

otra_r <- otra1 %>%
  filter(added_by.id == 'roos.hutter') %>%
  mutate(added_by.id = "Roos")

otra <- rbind(head(otra_r, 52), otra_w, head(otra_j, 52))

ggplot(otra, aes(x = valence, y = energy)) + 
  geom_jitter() + 
  geom_smooth() +
  facet_wrap(~ added_by.id) +
  labs(x = "Valence", y = "Energy") +
  theme_light()

otra_mean_median <- otra %>%
  group_by(added_by.id) %>%
  summarize(mean_energy = mean(energy),
            mean_valence = mean(valence),
            mean_acousticness = mean(acousticness),
            mean_loudness = mean(loudness),
            mean_tempo = mean(loudness),
            median_energy = median(energy),
            median_valence = median(valence),
            median_acousticness = median(acousticness),
            median_loudness = median(loudness),
            median_tempo = median(tempo))

ggplot(otra, aes(x=added_by.id, y=acousticness)) +
  geom_boxplot() +
  labs(x = '', y = "Acousticness") +
  theme_light()

otra |>                    # Start with awards.
  mutate(
    mode = ifelse(mode == 0, "Minor", "Major")
  ) |>
  ggplot(                     # Set up the plot.
    aes(
      x = valence,
      y = energy,
      size = loudness,
      colour = mode
    )
  ) +
  geom_point() +              # Scatter plot.
  geom_rug(linewidth = 0.1) + # Add 'fringes' to show data distribution.
  facet_wrap(~ added_by.id) +    # Separate charts per playlist.
  scale_x_continuous(         # Fine-tune the x axis.
    limits = c(0, 1),
    breaks = c(0, 0.50, 1),   # Use grid-lines for quadrants only.
    minor_breaks = NULL       # Remove 'minor' grid-lines.
  ) +
  scale_y_continuous(         # Fine-tune the y axis in the same way.
    limits = c(0, 1),
    breaks = c(0, 0.50, 1),
    minor_breaks = NULL
  ) +
  scale_colour_brewer(        # Use the Color Brewer to choose a palette.
    type = "qual",            # Qualitative set.
    palette = "Paired"        # Name of the palette is 'Paired'.
  ) +
  scale_size_continuous(      # Fine-tune the sizes of each point.
    trans = "exp",            # Use an exp transformation to emphasise loud.
    guide = "none"            # Remove the legend for size.
  ) +
  theme_light() +             # Use a simpler theme.
  labs(                       # Make the titles nice.
    x = "Valence",
    y = "Energy",
    colour = "Mode",
    title = "On the road (again) analysis"
  )

wood <-
  get_tidy_audio_analysis("1z6WtY7X4HQJvzxC4UgkSf") |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

wood |>
  mutate(pitches = map(pitches, compmus_normalise, "chebyshev")) |>
  compmus_gather_chroma() |> 
  ggplot(
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

