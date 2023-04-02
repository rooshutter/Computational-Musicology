pop <- ggplot(otra,
              aes(
                x = danceability,
                y = track.popularity,
                size = instrumentalness,
                colour = energy,
                text = paste("Track: ", track.name, "<br>",
                             "Danceability: ", danceability, "<br>",
                             "Popularity: ", track.popularity, "<br>",
                             "Instrumentalness: ", instrumentalness, "<br>",
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
    limits = c(0, 100),
    breaks = c(0, 50, 100),
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
    x = "Danceability",
    y = "Popularity",
    colour = "Energy",
    size = "Instrumentalness",
    title = "Danceability, Popularity, Instrumentalness and Energy"
  )

#ggplotly(pop, tooltip = "text")

saveRDS(object = pop, file = "data/pop.RDS")
