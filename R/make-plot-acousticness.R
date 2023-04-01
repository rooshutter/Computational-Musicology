#plot_acousticness <- ggplot(otra, aes(x=added_by.id, y=acousticness)) +
#  geom_boxplot() +
#  labs(x = '', y = "Acousticness", title = "Acousticness") +
#  theme_light()

otra_evm <- otra %>%
  mutate(
    mode = ifelse(mode == 0, "Minor", "Major")
  )

plot_acousticness <- ggplot(otra_evm,
                   aes(
                     x = valence,
                     y = acousticness,
                     size = loudness,
                     colour = mode, 
                     text = paste("Track: ", track.name, "<br>",
                                  "Valence: ", valence, "<br>",
                                  "Acousticness: ", acousticness, "<br>",
                                  "Loudness: ", loudness, "<br>",
                                  "Mode: ", mode, "<br>"
                   )
)) +
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
    y = "Acousticness",
    colour = "Mode",
    title = "Valence, Acousticness, Loudness and Mode"
  )

saveRDS(object = plot_acousticness, file = "data/plot_acousticness.RDS")
