#plot_acousticness <- ggplot(otra, aes(x=added_by.id, y=acousticness)) +
#  geom_boxplot() +
#  labs(x = '', y = "Acousticness", title = "Acousticness") +
#  theme_light()

plot_acousticness <- ggplot(otra,
                   aes(
                     x = valence,
                     y = acousticness,
                     size = loudness,
                     colour = energy, 
                     text = paste("Track: ", track.name, "<br>",
                                  "Valence: ", valence, "<br>",
                                  "Acousticness: ", acousticness, "<br>",
                                  "Loudness: ", loudness, "<br>",
                                  "Energy: ", energy, "<br>"
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
  scale_colour_continuous(        # Use the Color Brewer to choose a palette.
    type = "gradient"        # Name of the palette is 'Paired'.
  ) +
  scale_size_continuous(      # Fine-tune the sizes of each point.
    trans = "exp",            # Use an exp transformation to emphasise loud.
    guide = "none"            # Remove the legend for size.
  ) +
  theme_light() +             # Use a simpler theme.
  labs(                       # Make the titles nice.
    x = "Valence",
    y = "Acousticness",
    colour = "Energy",
    title = "Valence, Acousticness, Loudness and Energy"
  )

#ggplotly(plot_acousticness, tooltip = "text")

saveRDS(object = plot_acousticness, file = "data/plot_acousticness.RDS")
