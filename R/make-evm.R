otra_evm <- otra %>%
  mutate(
    mode = ifelse(mode == 0, "Minor", "Major")
  )

plot_evm <- ggplot(otra_evm,
                   aes(
                     x = danceability,
                     y = energy,
                     size = loudness,
                     colour = mode,
                     text = paste("Track: ", track.name, "<br>",
                                  "Danceability: ", danceability, "<br>",
                                  "Energy: ", energy, "<br>",
                                  "Loudness: ", loudness, "<br>",
                                  "Mode: ", mode, "<br>"
                     )
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
    x = "Danceability",
    y = "Energy",
    colour = "Mode",
    title = "Energy, Danceability, Loudness and Mode"
  )

#ggplotly(plot_evm, tooltip = "text")

saveRDS(object = plot_evm, file = "data/plot_evm.RDS")
