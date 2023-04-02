color_scale <- scale_color_gradient(low = "white", high = "#1e2d4b", guide = guide_colorbar(title = "Magnitude"))

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
  color_scale +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal()

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
  color_scale +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal() + 
  theme(legend.position = "none") 

#subplot(plot_chroma2, plot_chroma, nrows = 2, margin = 0.04, heights = c(0.5, 0.5)) %>% layout(annotations = 
#                                                                                                 list(list(x = 0.5,  y = 1.0,  
#                                                                                                           text = "Crazy Little Thing Called Love - Remastered 2011 - Queen",   
#                                                                                                           xref = "paper",  
#                                                                                                           yref = "paper",  
#                                                                                                           xanchor = "center",  
#                                                                                                           yanchor = "bottom",  
#                                                                                                           showarrow = FALSE ),        list(x = 0.5, y = 0.46,  
#                                                                                                                                            text = "Crazy Little Thing Called Love - Acoustic Version - Maroon 5",   
#                                                                                                                                            xref = "paper",  
#                                                                                                                                            yref = "paper",  
#                                                                                                                                            xanchor = "center",  
#                                                                                                                                            yanchor = "bottom",  
#                                                                                                                                            showarrow = FALSE )))

saveRDS(object = plot_chroma, file = "data/plot_chroma.RDS")
saveRDS(object = plot_chroma2, file = "data/plot_chroma2.RDS")
