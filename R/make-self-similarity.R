bzt <-
  get_tidy_audio_analysis("5YCXiEpUqblYW5x9vWx8Qd") |>
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

saveRDS(object = bzt, file = "data/bzt.RDS")
