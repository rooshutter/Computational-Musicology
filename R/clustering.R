library(flexdashboard)
library(readr)
library(leaflet)
library(DT)
library(tidyverse)
library(lubridate)
library(plotly)
library(spotifyr)
library(Cairo)
library(compmus)
library(ggdendro)
library(heatmaply)
library(tidymodels)

otra_j <- otra %>%
  filter(added_by.id == '1153531084') %>%
  mutate(added_by.id = "Julia")

otra_w <- otra %>%
  filter(added_by.id == '1168120441') %>%
  mutate(added_by.id = "Willemijn")

otra_r <- otra %>%
  filter(added_by.id == 'roos.hutter') %>%
  mutate(added_by.id = "Roos")

otra2 <- rbind(head(otra_r, 10), head(otra_w, 10), head(otra_j, 10))

get_conf_mat <- function(fit) {
  outcome <- .get_tune_outcome_names(fit)
  fit |> 
    collect_predictions() |> 
    conf_mat(truth = outcome, estimate = .pred_class)
}  

get_pr <- function(fit) {
  fit |> 
    conf_mat_resampled() |> 
    group_by(Prediction) |> mutate(precision = Freq / sum(Freq)) |> 
    group_by(Truth) |> mutate(recall = Freq / sum(Freq)) |> 
    ungroup() |> filter(Prediction == Truth) |> 
    select(class = Prediction, precision, recall)
}  

indie_juice <-
  recipe(
    track.name ~
      danceability +
      energy +
      loudness +
      speechiness +
      acousticness +
      instrumentalness +
      liveness +
      valence +
      tempo,
    data = otra2
  ) |>
  step_center(all_predictors()) |>
  step_scale(all_predictors()) |> 
  # step_range(all_predictors()) |> 
  prep(otra2 |> mutate(track.name = str_trunc(track.name, 15))) |>
  juice() |>
  column_to_rownames("track.name")

indie_dist <- dist(indie_juice, method = "euclidean")

data_for_indie_clustering <- indie_dist |> 
  hclust(method = "average") |> # average for a balanced tree!
  dendro_data() 

playlist_data_for_join <- otra2 %>%
  select(track.name, added_by.id) %>%
  mutate(label = str_trunc(track.name, 15))

data_for_indie_clustering$labels <- data_for_indie_clustering$labels %>%
  left_join(playlist_data_for_join)

# Add factor so can use colouring! 
data_for_indie_clustering$labels$label <- factor(data_for_indie_clustering$labels$label)

clustering <- data_for_indie_clustering |>
  ggdendrogram() +
  geom_text(data = label(data_for_indie_clustering), aes(x, y, 
                                                         label=label, 
                                                         hjust=0, 
                                                         colour=added_by.id), size=3) +
  coord_flip() + 
  scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank()) +
  labs(title = "Added by Clustering") +
  guides(
    colour = guide_legend(
      title = "Added by"
    )
  )

saveRDS(object = clustering, file = "data/clustering.RDS")
