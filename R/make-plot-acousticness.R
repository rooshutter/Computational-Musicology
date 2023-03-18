plot_acousticness <- ggplot(otra, aes(x=added_by.id, y=acousticness)) +
  geom_boxplot() +
  labs(x = '', y = "Acousticness", title = "Acousticness") +
  theme_light()

saveRDS(object = plot_acousticness, file = "data/plot_acousticness.RDS")
