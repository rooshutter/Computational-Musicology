library(grid)
library(gridExtra)

el <-
  get_tidy_audio_analysis("00hzFg3J78uIchXYUJVa5U") |>
  compmus_align(bars, segments) |>
  select(bars) |>
  unnest(bars) |>
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "acentre", norm = "manhattan"
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = "mean"
      )
  )

ptb <-
  get_tidy_audio_analysis("4KktZd9BGHZjW3sK03O4zo") |>
  compmus_align(bars, segments) |>
  select(bars) |>
  unnest(bars) |>
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "acentre", norm = "manhattan"
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = "mean"
      )
  )



saveRDS(object = el, file = "data/el.RDS")
saveRDS(object = ptb, file = "data/ptb.RDS")
